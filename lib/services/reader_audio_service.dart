import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum ReaderLanguage {
  arabic('Arabic', 'ar', 'textArabic'),
  urdu('Urdu', 'ur-PK', 'textUrdu'),
  farsi('Farsi', 'fa-IR', 'textFarsi'),
  english('English', 'en-US', 'textEnglish'),
  transliteration('Transliteration', 'en-US', 'transliteration');

  final String label;
  final String locale;
  final String jsonKey;

  const ReaderLanguage(this.label, this.locale, this.jsonKey);
}

class ReaderLine {
  final int number;
  final String textArabic;
  final String textUrdu;
  final String textFarsi;
  final String textEnglish;
  final String transliteration;
  final String audioUrl;

  const ReaderLine({
    required this.number,
    required this.textArabic,
    required this.textUrdu,
    required this.textFarsi,
    required this.textEnglish,
    required this.transliteration,
    required this.audioUrl,
  });

  factory ReaderLine.fromJson(Map<String, dynamic> json) {
    return ReaderLine(
      number: json['number'] as int? ??
          json['ayahNumber'] as int? ??
          json['lineNumber'] as int? ??
          0,
      textArabic: json['textArabic'] as String? ?? '',
      textUrdu: json['textUrdu'] as String? ?? '',
      textFarsi: json['textFarsi'] as String? ?? '',
      textEnglish: json['textEnglish'] as String? ?? '',
      transliteration: json['transliteration'] as String? ?? '',
      audioUrl: json['audioUrl'] as String? ?? '',
    );
  }

  String textFor(ReaderLanguage language) {
    switch (language) {
      case ReaderLanguage.arabic:
        return textArabic;
      case ReaderLanguage.urdu:
        return textUrdu;
      case ReaderLanguage.farsi:
        return textFarsi;
      case ReaderLanguage.english:
        return textEnglish;
      case ReaderLanguage.transliteration:
        return transliteration;
    }
  }
}

class ReaderAudioService {
  ReaderAudioService._();

  static final ReaderAudioService instance = ReaderAudioService._();

  final FlutterTts _tts = FlutterTts();
  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  final ValueNotifier<int?> currentLine = ValueNotifier<int?>(null);
  final ValueNotifier<String> currentTitle = ValueNotifier<String>('');
  final ValueNotifier<String> statusMessage =
      ValueNotifier<String>('Ready to read');
  final ValueNotifier<ReaderLanguage> language =
      ValueNotifier<ReaderLanguage>(ReaderLanguage.arabic);

  List<ReaderLine> _sourceLines = [];
  List<ReaderLine> _playableLines = [];
  int _index = 0;
  int _playToken = 0;
  bool _configured = false;
  bool _stopping = false;

  Future<void> configure() async {
    if (_configured) return;
    await _tts.awaitSpeakCompletion(true);
    await _tts.setSpeechRate(0.42);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _tts.setErrorHandler((message) {
      statusMessage.value = 'Voice error: $message';
      isPlaying.value = false;
    });
    _tts.setCancelHandler(() {
      isPlaying.value = false;
      currentLine.value = null;
      statusMessage.value = 'Reading stopped';
    });
    _configured = true;
  }

  Future<void> playLines({
    required String title,
    required List<ReaderLine> lines,
    ReaderLanguage? preferredLanguage,
    int startIndex = 0,
  }) async {
    await configure();
    _stopping = true;
    await _tts.stop();

    final token = ++_playToken;
    final selectedLanguage = await _bestLanguageForLines(
      lines,
      preferredLanguage ?? language.value,
    );
    final playableLines = lines
        .where((line) => line.textFor(selectedLanguage).trim().isNotEmpty)
        .toList();

    if (playableLines.isEmpty) {
      _sourceLines = lines;
      _playableLines = const [];
      _index = 0;
      currentTitle.value = title;
      isPlaying.value = false;
      currentLine.value = null;
      statusMessage.value = 'No readable text is available for this item';
      return;
    }

    _sourceLines = lines;
    _playableLines = playableLines;
    _index = startIndex.clamp(0, playableLines.length - 1);
    currentTitle.value = title;
    language.value = selectedLanguage;
    _stopping = false;
    isPlaying.value = true;
    statusMessage.value = 'Reading ${selectedLanguage.label}';

    await _speakLoop(token);
  }

  Future<void> playSingle({
    required String title,
    required ReaderLine line,
    ReaderLanguage? preferredLanguage,
  }) async {
    await playLines(
      title: title,
      lines: [line],
      preferredLanguage: preferredLanguage,
    );
  }

  Future<void> stop() async {
    _stopping = true;
    _playToken += 1;
    await _tts.stop();
    isPlaying.value = false;
    currentLine.value = null;
    statusMessage.value = 'Reading stopped';
  }

  Future<void> setLanguage(ReaderLanguage nextLanguage) async {
    language.value = nextLanguage;
    if (isPlaying.value) {
      await playLines(
        title: currentTitle.value,
        lines: _sourceLines,
        preferredLanguage: nextLanguage,
        startIndex: _index,
      );
    }
  }

  Future<void> _speakLoop(int token) async {
    while (
        !_stopping && token == _playToken && _index < _playableLines.length) {
      final line = _playableLines[_index];
      final text = line.textFor(language.value).trim();
      if (text.isNotEmpty) {
        currentLine.value = line.number;
        await _tts.setLanguage(language.value.locale);
        for (final chunk in _chunksForTts(text)) {
          if (_stopping || token != _playToken) break;
          await _tts.speak(chunk);
        }
      }
      _index += 1;
    }

    if (!_stopping && token == _playToken) {
      isPlaying.value = false;
      currentLine.value = null;
      statusMessage.value = 'Reading complete';
    }
  }

  Future<ReaderLanguage> _bestLanguageForLines(
    List<ReaderLine> lines,
    ReaderLanguage requested,
  ) async {
    final candidates = <ReaderLanguage>[
      requested,
      language.value,
      ReaderLanguage.arabic,
      ReaderLanguage.urdu,
      ReaderLanguage.farsi,
      ReaderLanguage.english,
      ReaderLanguage.transliteration,
    ];

    final uniqueCandidates = <ReaderLanguage>[];
    for (final candidate in candidates) {
      if (!uniqueCandidates.contains(candidate)) {
        uniqueCandidates.add(candidate);
      }
    }

    for (final candidate in uniqueCandidates) {
      if (!_hasText(lines, candidate)) continue;
      if (await _isLanguageAvailable(candidate)) return candidate;
    }

    for (final candidate in uniqueCandidates) {
      if (_hasText(lines, candidate)) return candidate;
    }

    return requested;
  }

  bool _hasText(List<ReaderLine> lines, ReaderLanguage candidate) {
    return lines.any((line) => line.textFor(candidate).trim().isNotEmpty);
  }

  Future<bool> _isLanguageAvailable(ReaderLanguage candidate) async {
    if (kIsWeb) return true;
    try {
      final available = await _tts.isLanguageAvailable(candidate.locale);
      return available == true || available == 1;
    } catch (_) {
      return true;
    }
  }

  List<String> _chunksForTts(String text) {
    const maxChunkLength = 2600;
    if (text.length <= maxChunkLength) return [text];

    final chunks = <String>[];
    final buffer = StringBuffer();
    final words = text.split(RegExp(r'\s+'));
    for (final word in words) {
      if (buffer.length + word.length + 1 > maxChunkLength) {
        final chunk = buffer.toString().trim();
        if (chunk.isNotEmpty) chunks.add(chunk);
        buffer.clear();
      }
      buffer.write(word);
      buffer.write(' ');
    }
    final tail = buffer.toString().trim();
    if (tail.isNotEmpty) chunks.add(tail);
    return chunks.isEmpty ? [text] : chunks;
  }
}
