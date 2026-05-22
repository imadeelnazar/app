import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/models.dart';

class DatabaseService {
  static late Isar _isar;
  static Future<void>? _initializationFuture;
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    final existing = _initializationFuture;
    if (existing != null) return existing;

    _initializationFuture = _initialize().catchError((error) {
      _initializationFuture = null;
      throw error;
    });
    return _initializationFuture;
  }

  static Future<void> _initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        QuranSchema,
        QuranAyahSchema,
        DuaSchema,
        DuaLineSchema,
        BookSchema,
        BookSectionSchema,
        ZiyarahSchema,
        ZiyarahLineSchema,
        AudioTrackSchema,
        AudioTimestampSchema,
        BookmarkSchema,
        FavoriteSchema,
        ReadingProgressSchema,
        AppSettingsSchema,
        CategorySchema,
        EventNotificationSchema,
        PrayerTimeSchema,
        DailyDuaSchema,
        AamaalSchema,
      ],
      directory: dir.path,
    );

    // Auto-seed on first launch
    await _seedDatabase();
    _initialized = true;
  }

  static Future<void> _seedDatabase() async {
    final quranCount = await _isar.qurans.count();
    if (quranCount == 0) {
      await _seedQuran();
      await _seedDuas();
      await _seedBooks();
      await _seedZiyaraat();
      await _seedCategories();
      await _seedAamaal();
      await _initializeSettings();
    }
  }

  static Future<void> _seedQuran() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/quran.json');
      final data = json.decode(jsonString);

      final qurans = <Quran>[];
      final ayahs = <QuranAyah>[];

      for (var surah in data['surahs'] ?? []) {
        qurans.add(Quran()
          ..surahNumber = surah['number'] ?? 0
          ..surahName = surah['name'] ?? ''
          ..surahNameArabic = surah['nameArabic'] ?? ''
          ..meaning = surah['meaning'] ?? ''
          ..ayahCount = surah['ayahCount'] ?? 0
          ..revelationType = surah['revelationType'] ?? ''
          ..bismillah = surah['bismillah'] ?? ''
          ..index = surah['number'] ?? 0);

        for (var ayah in surah['ayahs'] ?? []) {
          ayahs.add(QuranAyah()
            ..surahNumber = surah['number'] ?? 0
            ..ayahNumber = ayah['number'] ?? 0
            ..textArabic = ayah['textArabic'] ?? ''
            ..textEnglish = ayah['textEnglish'] ?? ''
            ..textUrdu = ayah['textUrdu'] ?? ''
            ..textFarsi = ayah['textFarsi'] ?? ''
            ..transliteration = ayah['transliteration'] ?? ''
            ..audioUrls = List<String>.from(ayah['audioUrls'] ?? [])
            ..surahNumberIndex = surah['number'] ?? 0);
        }
      }

      await _isar.writeTxn(() async {
        await _isar.qurans.putAll(qurans);
        await _isar.quranAyahs.putAll(ayahs);
      });
    } catch (e) {
      print('Error seeding Quran: $e');
    }
  }

  static Future<void> _seedDuas() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/duas.json');
      final data = json.decode(jsonString);

      final duas = <Dua>[];
      final lines = <DuaLine>[];

      for (var dua in data['duas'] ?? []) {
        final duaId = duas.length + 1;
        duas.add(Dua()
          ..name = dua['name'] ?? ''
          ..nameArabic = dua['nameArabic'] ?? ''
          ..description = dua['description'] ?? ''
          ..category = dua['category'] ?? ''
          ..duaNumber = duaId
          ..audioUrl = dua['audioUrl'] ?? ''
          ..index = duaId);

        for (var lineData in dua['lines'] ?? []) {
          lines.add(DuaLine()
            ..duaId = duaId
            ..lineNumber = lineData['number'] ?? 0
            ..textArabic = lineData['textArabic'] ?? ''
            ..textEnglish = lineData['textEnglish'] ?? ''
            ..textUrdu = lineData['textUrdu'] ?? ''
            ..textFarsi = lineData['textFarsi'] ?? ''
            ..transliteration = lineData['transliteration'] ?? ''
            ..audioUrl = lineData['audioUrl']
            ..audioStartTime = lineData['audioStartTime']
            ..audioEndTime = lineData['audioEndTime']
            ..duaIdIndex = duaId);
        }
      }

      await _isar.writeTxn(() async {
        await _isar.duas.putAll(duas);
        await _isar.duaLines.putAll(lines);
      });
    } catch (e) {
      print('Error seeding Duas: $e');
    }
  }

  static Future<void> _seedBooks() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/books.json');
      final data = json.decode(jsonString);

      final books = <Book>[];
      final sections = <BookSection>[];

      for (var book in data['books'] ?? []) {
        final bookId = books.length + 1;
        books.add(Book()
          ..title = book['title'] ?? ''
          ..titleArabic = book['titleArabic'] ?? ''
          ..author = book['author'] ?? ''
          ..description = book['description'] ?? ''
          ..category = book['category'] ?? ''
          ..sectionCount = (book['sections'] as List?)?.length ?? 0
          ..index = bookId);

        for (var section in book['sections'] ?? []) {
          sections.add(BookSection()
            ..bookId = bookId
            ..sectionNumber = section['number'] ?? 0
            ..title = section['title'] ?? ''
            ..content = section['content'] ?? ''
            ..contentArabic = section['contentArabic'] ?? ''
            ..contentUrdu = section['contentUrdu']
            ..contentFarsi = section['contentFarsi']
            ..bookIdIndex = bookId);
        }
      }

      await _isar.writeTxn(() async {
        await _isar.books.putAll(books);
        await _isar.bookSections.putAll(sections);
      });
    } catch (e) {
      print('Error seeding Books: $e');
    }
  }

  static Future<void> _seedZiyaraat() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/json/ziyaraat.json');
      final data = json.decode(jsonString);

      final ziyaraat = <Ziyarah>[];
      final lines = <ZiyarahLine>[];

      for (var ziyarah in data['ziyaraat'] ?? []) {
        final ziyarahId = ziyaraat.length + 1;
        ziyaraat.add(Ziyarah()
          ..name = ziyarah['name'] ?? ''
          ..nameArabic = ziyarah['nameArabic'] ?? ''
          ..description = ziyarah['description'] ?? ''
          ..category = ziyarah['category'] ?? ''
          ..occasion = ziyarah['occasion'] ?? ''
          ..audioUrl = ziyarah['audioUrl'] ?? ''
          ..index = ziyarahId);

        for (var lineData in ziyarah['lines'] ?? []) {
          lines.add(ZiyarahLine()
            ..ziyarahId = ziyarahId
            ..lineNumber = lineData['number'] ?? 0
            ..textArabic = lineData['textArabic'] ?? ''
            ..textEnglish = lineData['textEnglish'] ?? ''
            ..textUrdu = lineData['textUrdu'] ?? ''
            ..textFarsi = lineData['textFarsi'] ?? ''
            ..audioUrl = lineData['audioUrl']
            ..audioStartTime = lineData['audioStartTime']
            ..audioEndTime = lineData['audioEndTime']
            ..ziyarahIdIndex = ziyarahId);
        }
      }

      await _isar.writeTxn(() async {
        await _isar.ziyarahs.putAll(ziyaraat);
        await _isar.ziyarahLines.putAll(lines);
      });
    } catch (e) {
      print('Error seeding Ziyaraat: $e');
    }
  }

  static Future<void> _seedCategories() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/json/categories.json');
      final data = json.decode(jsonString);

      final categories = <Category>[];
      for (var cat in data['categories'] ?? []) {
        categories.add(Category()
          ..categoryId = cat['id'] ?? 0
          ..name = cat['name'] ?? ''
          ..nameArabic = cat['nameArabic'] ?? ''
          ..icon = cat['icon'] ?? ''
          ..order = cat['order'] ?? 0
          ..type = cat['type'] ?? '');
      }

      await _isar.writeTxn(() async {
        await _isar.categorys.putAll(categories);
      });
    } catch (e) {
      print('Error seeding Categories: $e');
    }
  }

  static Future<void> _seedAamaal() async {
    try {
      final jsonString = await rootBundle.loadString('assets/json/events.json');
      final data = json.decode(jsonString);

      final aamaal = <Aamaal>[];
      for (var event in data['events'] ?? []) {
        aamaal.add(Aamaal()
          ..month = event['month'] ?? ''
          ..day = event['day'] ?? 0
          ..title = event['title'] ?? ''
          ..titleArabic = event['titleArabic'] ?? ''
          ..description = event['description'] ?? ''
          ..content = event['content'] ?? ''
          ..contentArabic = event['contentArabic'] ?? ''
          ..contentUrdu = event['contentUrdu']
          ..contentFarsi = event['contentFarsi']);
      }

      await _isar.writeTxn(() async {
        await _isar.aamaals.putAll(aamaal);
      });
    } catch (e) {
      print('Error seeding Aamaal: $e');
    }
  }

  static Future<void> _initializeSettings() async {
    final settings = AppSettings()
      ..locale = 'en'
      ..darkMode = false
      ..fontSize = 16.0
      ..arabicFontSize = 24.0
      ..reciterPreference = 'default'
      ..notificationsEnabled = true
      ..azanNotifications = true
      ..eventNotifications = true
      ..lastKnownLatitude = 0.0
      ..lastKnownLongitude = 0.0
      ..lastKnownLocation = null
      ..settingsUpdateTime = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.appSettings.put(settings);
    });
  }

  // ==================== QURAN OPERATIONS ====================

  static Future<List<Quran>> getAllQurans() async {
    return await _isar.qurans.where().findAll();
  }

  static Future<Quran?> getQuranBySurahNumber(int surahNumber) async {
    return await _isar.qurans
        .filter()
        .surahNumberEqualTo(surahNumber)
        .findFirst();
  }

  static Future<List<QuranAyah>> getAyahsBySurah(int surahNumber) async {
    return await _isar.quranAyahs
        .filter()
        .surahNumberEqualTo(surahNumber)
        .findAll();
  }

  // ==================== BOOKMARK OPERATIONS ====================

  static Future<void> addBookmark({
    required String contentType,
    required int contentId,
    required String title,
    required String preview,
    int? lineNumber,
  }) async {
    final bookmark = Bookmark()
      ..contentType = contentType
      ..contentId = contentId
      ..lineNumber = lineNumber
      ..title = title
      ..preview = preview
      ..createdAt = DateTime.now()
      ..createdAtIndex = DateTime.now()
      ..lastUpdated = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.bookmarks.put(bookmark);
    });
  }

  static Future<List<Bookmark>> getAllBookmarks() async {
    return await _isar.bookmarks.where().findAll();
  }

  static Future<void> deleteBookmark(int id) async {
    await _isar.writeTxn(() async {
      await _isar.bookmarks.delete(id);
    });
  }

  // ==================== PRAYER TIMES ====================

  static Future<void> savePrayerTimes(PrayerTime prayerTime) async {
    await _isar.writeTxn(() async {
      await _isar.prayerTimes.put(prayerTime);
    });
  }

  static Future<PrayerTime?> getPrayerTimes(DateTime date) async {
    return await _isar.prayerTimes
        .filter()
        .dateBetween(
          DateTime(date.year, date.month, date.day),
          DateTime(date.year, date.month, date.day, 23, 59, 59),
        )
        .findFirst();
  }

  // ==================== READING PROGRESS ====================

  static Future<void> updateReadingProgress({
    required String contentType,
    required int contentId,
    required int lastReadLine,
  }) async {
    final existing = await _isar.readingProgress
        .filter()
        .contentTypeEqualTo(contentType)
        .findFirst();

    final progress = existing ?? ReadingProgress()
      ..contentType = contentType
      ..contentTypeIndex = contentType
      ..contentId = contentId
      ..totalReadCount = 0;

    progress.lastReadLine = lastReadLine;
    progress.lastReadAt = DateTime.now();
    progress.totalReadCount = (progress.totalReadCount) + 1;

    await _isar.writeTxn(() async {
      await _isar.readingProgress.put(progress);
    });
  }

  static Future<ReadingProgress?> getReadingProgress(String contentType) async {
    return await _isar.readingProgress
        .filter()
        .contentTypeEqualTo(contentType)
        .findFirst();
  }

  // ==================== SETTINGS ====================

  static Future<AppSettings?> getSettings() async {
    return await _isar.appSettings.get(1);
  }

  static Future<void> updateSettings(AppSettings settings) async {
    await _isar.writeTxn(() async {
      await _isar.appSettings.put(settings);
    });
  }

  // ==================== DUAS ====================

  static Future<List<Dua>> getAllDuas() async {
    return await _isar.duas.where().findAll();
  }

  static Future<List<DuaLine>> getDuaLines(int duaId) async {
    return await _isar.duaLines.filter().duaIdEqualTo(duaId).findAll();
  }

  // ==================== ZIYARAAT ====================

  static Future<List<Ziyarah>> getAllZiyaraat() async {
    return await _isar.ziyarahs.where().findAll();
  }

  static Future<List<ZiyarahLine>> getZiyarahLines(int ziyarahId) async {
    return await _isar.ziyarahLines
        .filter()
        .ziyarahIdEqualTo(ziyarahId)
        .findAll();
  }

  // ==================== BOOKS ====================

  static Future<List<Book>> getAllBooks() async {
    return await _isar.books.where().findAll();
  }

  static Future<List<BookSection>> getBookSections(int bookId) async {
    return await _isar.bookSections.filter().bookIdEqualTo(bookId).findAll();
  }

  static Isar getInstance() => _isar;
  static Future<void> close() => _isar.close();
}
