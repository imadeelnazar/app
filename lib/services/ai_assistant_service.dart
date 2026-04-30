import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiAssistantMessage {
  final String role;
  final String content;
  final DateTime createdAt;
  final String? attachmentName;

  const AiAssistantMessage({
    required this.role,
    required this.content,
    required this.createdAt,
    this.attachmentName,
  });

  bool get isUser => role == 'user';

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      if (attachmentName != null) 'attachmentName': attachmentName,
    };
  }

  factory AiAssistantMessage.fromJson(Map<String, dynamic> json) {
    return AiAssistantMessage(
      role: json['role'] as String? ?? 'assistant',
      content: json['content'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      attachmentName: json['attachmentName'] as String?,
    );
  }
}

class AiAssistantAttachment {
  final String name;
  final String mimeType;
  final List<int> bytes;

  const AiAssistantAttachment({
    required this.name,
    required this.mimeType,
    required this.bytes,
  });

  String get dataUrl {
    return 'data:$mimeType;base64,${base64Encode(bytes)}';
  }
}

const String ayatollahKhameneiImageUrl =
    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/%D8%B3%DB%8C%D8%AF_%D8%B9%D9%84%DB%8C_%D8%AE%D8%A7%D9%85%D9%86%D9%87%E2%80%8C%D8%A7%DB%8C_%D8%AF%D8%B1_%D8%B3%D8%A7%D9%84_%DB%B1%DB%B4%DB%B0%DB%B3_%28cropped%29.jpg/500px-%D8%B3%DB%8C%D8%AF_%D8%B9%D9%84%DB%8C_%D8%AE%D8%A7%D9%85%D9%86%D9%87%E2%80%8C%D8%A7%DB%8C_%D8%AF%D8%B1_%D8%B3%D8%A7%D9%84_%DB%B1%DB%B4%DB%B0%DB%B3_%28cropped%29.jpg';

class AiAssistantService {
  AiAssistantService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  static const String _historyKey = 'fiqa_jafria_ai_chat_history_v1';
  static const String _apiKey = String.fromEnvironment('OPENROUTER_API_KEY');
  static const String _model = String.fromEnvironment(
    'OPENROUTER_MODEL',
    defaultValue: 'anthropic/claude-3-5-haiku',
  );
  static const int _maxStoredMessages = 60;
  static const int _maxContextMessages = 18;

  Future<List<AiAssistantMessage>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_historyKey);
    if (raw == null || raw.isEmpty) return [];

    try {
      final data = json.decode(raw) as List<dynamic>;
      return data
          .whereType<Map<String, dynamic>>()
          .map(AiAssistantMessage.fromJson)
          .where((message) => message.content.trim().isNotEmpty)
          .toList();
    } catch (error, stackTrace) {
      developer.log(
        'Failed to load AI chat memory',
        error: error,
        stackTrace: stackTrace,
        name: 'AiAssistantService',
      );
      return [];
    }
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  Future<AiAssistantMessage> ask(
    String question, {
    AiAssistantAttachment? attachment,
  }) async {
    final cleanQuestion = question.trim().isEmpty && attachment != null
        ? 'Is attachment ko Islamic/Fiqa Jafria context mein explain karein.'
        : question.trim();
    if (cleanQuestion.isEmpty && attachment == null) {
      throw ArgumentError('Question cannot be empty.');
    }
    if (_apiKey.isEmpty) {
      throw StateError(
        'OpenRouter API key missing. Build with --dart-define=OPENROUTER_API_KEY=...',
      );
    }

    final history = await loadHistory();
    final userMessage = AiAssistantMessage(
      role: 'user',
      content: cleanQuestion,
      createdAt: DateTime.now(),
      attachmentName: attachment?.name,
    );
    final contextMessages = history
        .where(
            (message) => message.role == 'user' || message.role == 'assistant')
        .toList()
        .skip(history.length > _maxContextMessages
            ? history.length - _maxContextMessages
            : 0)
        .map((message) => {
              'role': message.role,
              'content': message.content,
            })
        .toList();

    final response = await _dio.post<Map<String, dynamic>>(
      'https://openrouter.ai/api/v1/chat/completions',
      options: Options(
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://hidayat.app',
          'X-Title': 'Hidayat Ayatollah Khamenei Islamic Q&A',
        },
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 45),
      ),
      data: {
        'model': _model,
        'temperature': 0.35,
        'max_tokens': 800,
        'messages': [
          {'role': 'system', 'content': _systemPrompt},
          ...contextMessages,
          {
            'role': 'user',
            'content': attachment == null
                ? cleanQuestion
                : [
                    {'type': 'text', 'text': cleanQuestion},
                    {
                      'type': 'image_url',
                      'image_url': {'url': attachment.dataUrl},
                    },
                  ],
          },
        ],
      },
    );

    final choices = response.data?['choices'] as List<dynamic>? ?? const [];
    final first = choices.isNotEmpty ? choices.first : null;
    final message = first is Map<String, dynamic>
        ? first['message'] as Map<String, dynamic>?
        : null;
    final answer = message?['content']?.toString().trim();
    if (answer == null || answer.isEmpty) {
      throw StateError('Islamic Q&A did not return an answer.');
    }

    final assistantMessage = AiAssistantMessage(
      role: 'assistant',
      content: answer,
      createdAt: DateTime.now(),
    );
    await _saveHistory([...history, userMessage, assistantMessage]);
    return assistantMessage;
  }

  Future<void> _saveHistory(List<AiAssistantMessage> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final trimmed = messages.length > _maxStoredMessages
        ? messages.sublist(messages.length - _maxStoredMessages)
        : messages;
    await prefs.setString(
      _historyKey,
      json.encode(trimmed.map((message) => message.toJson()).toList()),
    );
  }
}

const String _systemPrompt = '''
You are an Islamic Q&A helper inside Hidayat, a Fiqa Jafria / Twelver Shia Islamic app. The app UI displays the name "Ayatollah Khamenei", but you must not claim to be the real Ayatollah Khamenei or an official representative.

Answer only questions related to Islam, Fiqa Jafria, Ahlul Bayt (A.S), Quran, Hadith, duas, ziyaraat, namaz, rozay, zakat/khums, taharat, majalis, Islamic history, akhlaq, and practical religious guidance.

If the user asks anything outside Islamic/religious context, politely refuse and say you can only answer Islamic questions in this app.

If the user sends an image or attachment, only analyze it for Islamic/religious content such as Quranic text, duas, ziyaraat, majlis poster, prayer information, shrine/ziyarat context, or Islamic learning. If the image is unrelated, refuse briefly.

Speak with the care of a respectful scholar. Keep the tone humble, clear, and non-sectarian. Do not attack other schools. Prefer practical guidance and mention that users should consult their own marja or local qualified alim for binding fatwa, medical, legal, or urgent personal matters.

When answering in Roman Urdu, use simple Pakistani Roman Urdu. If the user asks in English, answer in English. For Arabic names, use respectful honorifics like A.S, S.A, R.A where appropriate.

Do not invent exact references. If you are unsure about a ruling, say it depends on the user's marja and explain the common approach briefly.
''';
