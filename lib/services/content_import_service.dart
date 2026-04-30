import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

// ---------------------------------------------------------------------------
// Model
// ---------------------------------------------------------------------------

enum UploadedContentType { book, dua, ziyarat, quran, event, amaal, biography }

enum ContentStatus { draft, published }

enum CopyrightStatus { metadataOnly, permissionRequired, allowed }

class ContentItem {
  final int number;
  final String chapterTitle;
  final String sectionTitle;
  final String textArabic;
  final String textUrdu;
  final String textEnglish;
  final String textFarsi;
  final String reference;
  final String audioUrl;
  final double? audioStartTime;
  final double? audioEndTime;

  const ContentItem({
    required this.number,
    this.chapterTitle = '',
    this.sectionTitle = '',
    this.textArabic = '',
    this.textUrdu = '',
    this.textEnglish = '',
    this.textFarsi = '',
    this.reference = '',
    this.audioUrl = '',
    this.audioStartTime,
    this.audioEndTime,
  });

  factory ContentItem.fromJson(Map<String, dynamic> j) => ContentItem(
        number: (j['number'] as num?)?.toInt() ?? 0,
        chapterTitle: j['chapterTitle'] as String? ?? '',
        sectionTitle: j['sectionTitle'] as String? ?? '',
        textArabic: j['textArabic'] as String? ?? '',
        textUrdu: j['textUrdu'] as String? ?? '',
        textEnglish: j['textEnglish'] as String? ?? '',
        textFarsi: j['textFarsi'] as String? ?? '',
        reference: j['reference'] as String? ?? '',
        audioUrl: j['audioUrl'] as String? ?? '',
        audioStartTime: (j['audioStartTime'] as num?)?.toDouble(),
        audioEndTime: (j['audioEndTime'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'chapterTitle': chapterTitle,
        'sectionTitle': sectionTitle,
        'textArabic': textArabic,
        'textUrdu': textUrdu,
        'textEnglish': textEnglish,
        'textFarsi': textFarsi,
        'reference': reference,
        'audioUrl': audioUrl,
        'audioStartTime': audioStartTime,
        'audioEndTime': audioEndTime,
      };
}

class AudioFileEntry {
  final String file;
  final String localPath;
  final String contentId;
  final String chapter;
  final int lineNumber;
  final String addedAt;

  const AudioFileEntry({
    required this.file,
    required this.localPath,
    required this.contentId,
    this.chapter = '',
    this.lineNumber = 0,
    required this.addedAt,
  });

  factory AudioFileEntry.fromJson(Map<String, dynamic> j) => AudioFileEntry(
        file: j['file'] as String? ?? '',
        localPath: j['localPath'] as String? ?? '',
        contentId: j['contentId'] as String? ?? '',
        chapter: j['chapter'] as String? ?? '',
        lineNumber: (j['lineNumber'] as num?)?.toInt() ?? 0,
        addedAt: j['addedAt'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'file': file,
        'localPath': localPath,
        'contentId': contentId,
        'chapter': chapter,
        'lineNumber': lineNumber,
        'addedAt': addedAt,
      };
}

class UploadedContent {
  final String id;
  final String type;
  final String title;
  final String titleArabic;
  final String titleUrdu;
  final String titleFarsi;
  final String category;
  final String source;
  final String sourceUrl;
  final String author;
  final String description;
  final List<String> languages;
  final List<String> tags;
  final List<ContentItem> content;
  final List<AudioFileEntry> audioFiles;
  final String status;
  final String copyrightStatus;
  final String permissionNote;
  final String createdAt;
  final String updatedAt;

  const UploadedContent({
    required this.id,
    required this.type,
    required this.title,
    this.titleArabic = '',
    this.titleUrdu = '',
    this.titleFarsi = '',
    required this.category,
    this.source = '',
    this.sourceUrl = '',
    this.author = '',
    this.description = '',
    this.languages = const ['arabic', 'english', 'urdu', 'farsi'],
    this.tags = const [],
    required this.content,
    this.audioFiles = const [],
    this.status = 'draft',
    this.copyrightStatus = 'metadata_only',
    this.permissionNote = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory UploadedContent.fromJson(Map<String, dynamic> j) => UploadedContent(
        id: j['id'] as String? ?? '',
        type: j['type'] as String? ?? 'book',
        title: j['title'] as String? ?? '',
        titleArabic: j['titleArabic'] as String? ?? '',
        titleUrdu: j['titleUrdu'] as String? ?? '',
        titleFarsi: j['titleFarsi'] as String? ?? '',
        category: j['category'] as String? ?? '',
        source: j['source'] as String? ?? '',
        sourceUrl: j['sourceUrl'] as String? ?? '',
        author: j['author'] as String? ?? '',
        description: j['description'] as String? ?? '',
        languages:
            List<String>.from(j['languages'] as List? ?? ['arabic', 'english']),
        tags: List<String>.from(j['tags'] as List? ?? []),
        content: ((j['content'] as List?) ?? [])
            .map((e) => ContentItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        audioFiles: ((j['audioFiles'] as List?) ?? [])
            .map((e) => AudioFileEntry.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: j['status'] as String? ?? 'draft',
        copyrightStatus: j['copyrightStatus'] as String? ?? 'metadata_only',
        permissionNote: j['permissionNote'] as String? ?? '',
        createdAt: j['createdAt'] as String? ?? '',
        updatedAt: j['updatedAt'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'title': title,
        'titleArabic': titleArabic,
        'titleUrdu': titleUrdu,
        'titleFarsi': titleFarsi,
        'category': category,
        'source': source,
        'sourceUrl': sourceUrl,
        'author': author,
        'description': description,
        'languages': languages,
        'tags': tags,
        'content': content.map((c) => c.toJson()).toList(),
        'audioFiles': audioFiles.map((a) => a.toJson()).toList(),
        'status': status,
        'copyrightStatus': copyrightStatus,
        'permissionNote': permissionNote,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  UploadedContent copyWith({
    String? title,
    String? titleArabic,
    String? titleUrdu,
    String? titleFarsi,
    String? category,
    String? source,
    String? sourceUrl,
    String? author,
    String? description,
    List<String>? tags,
    List<ContentItem>? content,
    List<AudioFileEntry>? audioFiles,
    String? status,
    String? copyrightStatus,
    String? permissionNote,
  }) {
    final now = DateTime.now().toUtc().toIso8601String();
    return UploadedContent(
      id: id,
      type: type,
      title: title ?? this.title,
      titleArabic: titleArabic ?? this.titleArabic,
      titleUrdu: titleUrdu ?? this.titleUrdu,
      titleFarsi: titleFarsi ?? this.titleFarsi,
      category: category ?? this.category,
      source: source ?? this.source,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      author: author ?? this.author,
      description: description ?? this.description,
      languages: languages,
      tags: tags ?? this.tags,
      content: content ?? this.content,
      audioFiles: audioFiles ?? this.audioFiles,
      status: status ?? this.status,
      copyrightStatus: copyrightStatus ?? this.copyrightStatus,
      permissionNote: permissionNote ?? this.permissionNote,
      createdAt: createdAt,
      updatedAt: now,
    );
  }
}

// ---------------------------------------------------------------------------
// Service
// ---------------------------------------------------------------------------

class ContentImportService {
  ContentImportService._();
  static final instance = ContentImportService._();

  static const _prefKey = 'uploaded_content_ids';
  static const _uuid = Uuid();

  // ── Storage paths ────────────────────────────────────────────────────────

  Future<Directory> get _contentDir async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory('${docs.path}/islamic_library/imported');
    await dir.create(recursive: true);
    return dir;
  }

  Future<Directory> get _audioDir async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory('${docs.path}/islamic_audio');
    await dir.create(recursive: true);
    return dir;
  }

  Future<File> _contentFile(String id) async {
    final dir = await _contentDir;
    return File('${dir.path}/$id.json');
  }

  // ── Persistence helpers ──────────────────────────────────────────────────

  Future<List<String>> _loadIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_prefKey) ?? [];
  }

  Future<void> _saveId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = await _loadIds();
    if (!ids.contains(id)) {
      await prefs.setStringList(_prefKey, [...ids, id]);
    }
  }

  Future<void> _removeId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = await _loadIds();
    await prefs.setStringList(_prefKey, ids.where((e) => e != id).toList());
  }

  // ── CRUD ─────────────────────────────────────────────────────────────────

  Future<void> save(UploadedContent item) async {
    final file = await _contentFile(item.id);
    await file.writeAsString(
      jsonEncode(item.toJson()),
      encoding: utf8,
      flush: true,
    );
    await _saveId(item.id);
  }

  Future<UploadedContent?> load(String id) async {
    final file = await _contentFile(id);
    if (!await file.exists()) return null;
    final raw = await file.readAsString(encoding: utf8);
    return UploadedContent.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<List<UploadedContent>> loadAll() async {
    final ids = await _loadIds();
    final results = <UploadedContent>[];
    for (final id in ids) {
      final item = await load(id);
      if (item != null) results.add(item);
    }
    return results;
  }

  Future<void> delete(String id) async {
    final file = await _contentFile(id);
    if (await file.exists()) await file.delete();
    await _removeId(id);
  }

  Future<void> publish(String id) async {
    final item = await load(id);
    if (item == null) return;
    await save(item.copyWith(status: 'published'));
  }

  Future<void> unpublish(String id) async {
    final item = await load(id);
    if (item == null) return;
    await save(item.copyWith(status: 'draft'));
  }

  // ── File import ──────────────────────────────────────────────────────────

  /// Open the system file picker and return selected files.
  Future<List<PlatformFile>> pickFiles({
    List<String> extensions = const ['json', 'txt', 'mp3', 'pdf'],
    bool allowMultiple = false,
  }) async {
    final result = await FilePicker.pickFiles(
      allowMultiple: allowMultiple,
      type: FileType.custom,
      allowedExtensions: extensions,
      withData: true,
    );
    return result?.files ?? [];
  }

  /// Process a picked file into an UploadedContent record.
  Future<UploadedContent> processFile(
    PlatformFile picked, {
    required String contentType,
    required String title,
    String category = '',
    String source = '',
    String sourceUrl = '',
    String author = '',
    String description = '',
    List<String> tags = const [],
  }) async {
    final now = DateTime.now().toUtc().toIso8601String();
    final id = _uuid.v4().substring(0, 10);

    final ext = (picked.extension ?? '').toLowerCase();

    List<ContentItem> items = [];

    if (ext == 'json') {
      items = await _processJson(picked);
    } else if (ext == 'txt') {
      items = _parseTxt(
        utf8.decode(picked.bytes ?? [], allowMalformed: true),
      );
    } else if (ext == 'mp3') {
      // MP3 handled separately via addAudioFile
      items = [];
    } else {
      throw UnsupportedError(
        'File type .$ext is not supported for automatic processing.\n'
        'Please convert to .txt or .json first.',
      );
    }

    return UploadedContent(
      id: id,
      type: contentType,
      title: title.isEmpty
          ? (picked.name.replaceAll(RegExp(r'\.\w+$'), ''))
          : title,
      category: category,
      source: source,
      sourceUrl: sourceUrl,
      author: author,
      description: description,
      tags: tags,
      content: items,
      status: 'draft',
      copyrightStatus: 'metadata_only',
      createdAt: now,
      updatedAt: now,
    );
  }

  Future<List<ContentItem>> _processJson(PlatformFile picked) async {
    final raw = utf8.decode(picked.bytes ?? [], allowMalformed: true);
    final json = jsonDecode(raw) as Map<String, dynamic>;

    // Accept both direct content array or a book/dua JSON with content field
    final rawContent = json['content'] as List?;
    if (rawContent == null) {
      throw FormatException(
        'JSON file has no "content" array. Please ensure it follows the expected schema.',
      );
    }
    return rawContent.asMap().entries.map((e) {
      final item = e.value as Map<String, dynamic>;
      item['number'] = (item['number'] as num?)?.toInt() ?? (e.key + 1);
      return ContentItem.fromJson(item);
    }).toList();
  }

  List<ContentItem> _parseTxt(String raw) {
    final paragraphs = raw
        .split(RegExp(r'\n{2,}'))
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();

    final items = <ContentItem>[];
    int num = 1;
    int i = 0;

    while (i < paragraphs.length) {
      final para = paragraphs[i];
      final isArabic = _hasArabic(para);

      String arabic = '';
      String english = '';

      if (isArabic) {
        arabic = para;
        if (i + 1 < paragraphs.length && !_hasArabic(paragraphs[i + 1])) {
          english = paragraphs[i + 1];
          i += 2;
        } else {
          i++;
        }
      } else {
        english = para;
        i++;
      }

      items.add(ContentItem(
        number: num++,
        textArabic: arabic,
        textEnglish: english,
      ));
    }
    return items;
  }

  bool _hasArabic(String text) {
    return text.runes.any((r) => r >= 0x0600 && r <= 0x06FF);
  }

  // ── Audio management ─────────────────────────────────────────────────────

  /// Copy a picked MP3 into local storage and link it to a content item.
  Future<AudioFileEntry> addAudioFile(
    PlatformFile picked,
    String contentId, {
    String chapter = '',
    int lineNumber = 0,
  }) async {
    final audioRoot = await _audioDir;
    final contentAudioDir = Directory('${audioRoot.path}/$contentId');
    await contentAudioDir.create(recursive: true);

    final dest = File('${contentAudioDir.path}/${picked.name}');
    await dest.writeAsBytes(picked.bytes ?? [], flush: true);

    final entry = AudioFileEntry(
      file: picked.name,
      localPath: dest.path,
      contentId: contentId,
      chapter: chapter,
      lineNumber: lineNumber,
      addedAt: DateTime.now().toUtc().toIso8601String(),
    );

    // Attach to content
    final item = await load(contentId);
    if (item != null) {
      final updated = item.copyWith(
        audioFiles: [...item.audioFiles, entry],
      );
      await save(updated);
    }
    return entry;
  }

  Future<void> deleteAudioFile(String contentId, String fileName) async {
    final item = await load(contentId);
    if (item == null) return;

    final entry = item.audioFiles.where((a) => a.file == fileName).firstOrNull;
    if (entry != null) {
      final f = File(entry.localPath);
      if (await f.exists()) await f.delete();
    }

    await save(
      item.copyWith(
        audioFiles: item.audioFiles.where((a) => a.file != fileName).toList(),
      ),
    );
  }

  // ── Export ───────────────────────────────────────────────────────────────

  /// Return a pretty-printed JSON string of the content (for sharing / export).
  Future<String> exportJson(String id) async {
    final item = await load(id);
    if (item == null) throw StateError('Content not found: $id');
    return const JsonEncoder.withIndent('  ').convert(item.toJson());
  }

  /// Return summary stats for the admin dashboard.
  Future<Map<String, int>> stats() async {
    final all = await loadAll();
    int published = 0, draft = 0, withAudio = 0;
    final typeCounts = <String, int>{};
    for (final item in all) {
      if (item.status == 'published') {
        published++;
      } else {
        draft++;
      }
      if (item.audioFiles.isNotEmpty) withAudio++;
      typeCounts[item.type] = (typeCounts[item.type] ?? 0) + 1;
    }
    return {
      'total': all.length,
      'published': published,
      'draft': draft,
      'withAudio': withAudio,
      ...typeCounts,
    };
  }
}
