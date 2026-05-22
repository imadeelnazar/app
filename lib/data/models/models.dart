import 'package:isar/isar.dart';

part 'models.g.dart';

// ==================== QURAN ====================

@collection
class Quran {
  Id id = Isar.autoIncrement;

  late int surahNumber;
  late String surahName;
  late String surahNameArabic;
  late String meaning;
  late int ayahCount;
  late String revelationType; // Makki or Madani
  late String bismillah;

  @Index()
  late int index;
}

@collection
class QuranAyah {
  Id id = Isar.autoIncrement;

  late int surahNumber;
  late int ayahNumber;
  late String textArabic;
  late String textEnglish;
  late String textUrdu;
  late String textFarsi;
  late String transliteration;
  late List<String> audioUrls; // Different reciters

  @Index()
  late int surahNumberIndex;
}

// ==================== DUAS ====================

@collection
class Dua {
  Id id = Isar.autoIncrement;

  late String name;
  late String nameArabic;
  late String description;
  late String category;
  late int duaNumber;
  late String audioUrl;

  @Index()
  late int index;
}

@collection
class DuaLine {
  Id id = Isar.autoIncrement;

  late int duaId;
  late int lineNumber;
  late String textArabic;
  late String textEnglish;
  late String textUrdu;
  late String textFarsi;
  late String transliteration;
  late String? audioUrl;
  late int? audioStartTime;
  late int? audioEndTime;

  @Index()
  late int duaIdIndex;
}

// ==================== BOOKS ====================

@collection
class Book {
  Id id = Isar.autoIncrement;

  late String title;
  late String titleArabic;
  late String author;
  late String description;
  late String category;
  late int sectionCount;

  @Index()
  late int index;
}

@collection
class BookSection {
  Id id = Isar.autoIncrement;

  late int bookId;
  late int sectionNumber;
  late String title;
  late String content;
  late String contentArabic;
  late String? contentUrdu;
  late String? contentFarsi;

  @Index()
  late int bookIdIndex;
}

// ==================== ZIYARAAT ====================

@collection
class Ziyarah {
  Id id = Isar.autoIncrement;

  late String name;
  late String nameArabic;
  late String description;
  late String category;
  late String occasion;
  late String audioUrl;

  @Index()
  late int index;
}

@collection
class ZiyarahLine {
  Id id = Isar.autoIncrement;

  late int ziyarahId;
  late int lineNumber;
  late String textArabic;
  late String textEnglish;
  late String textUrdu;
  late String textFarsi;
  late String? audioUrl;
  late int? audioStartTime;
  late int? audioEndTime;

  @Index()
  late int ziyarahIdIndex;
}

// ==================== AUDIO ====================

@collection
class AudioTrack {
  Id id = Isar.autoIncrement;

  late String title;
  late String artist;
  late String url;
  late int duration;
  late String contentType; // quran, dua, ziyarah
  late int contentId;

  @Index()
  late String urlIndex;
}

@collection
class AudioTimestamp {
  Id id = Isar.autoIncrement;

  late int audioId;
  late int lineNumber;
  late int startTime;
  late int endTime;

  @Index()
  late int audioIdIndex;
}

// ==================== BOOKMARKS ====================

@collection
class Bookmark {
  Id id = Isar.autoIncrement;

  late DateTime createdAt;
  late DateTime lastUpdated;
  late String contentType; // quran, dua, book, ziyarah
  late int contentId;
  late int? lineNumber;
  late String title;
  late String preview;

  @Index()
  late DateTime createdAtIndex;
}

// ==================== FAVORITES ====================

@collection
class Favorite {
  Id id = Isar.autoIncrement;

  late DateTime createdAt;
  late String contentType;
  late int contentId;
  late String title;

  @Index()
  late DateTime createdAtIndex;
}

// ==================== READING PROGRESS ====================

@collection
class ReadingProgress {
  Id id = Isar.autoIncrement;

  late String contentType;
  late int contentId;
  late int lastReadLine;
  late DateTime lastReadAt;
  late int totalReadCount;

  @Index()
  late String contentTypeIndex;
}

// ==================== SETTINGS ====================

@collection
class AppSettings {
  Id id = Isar.autoIncrement;

  late String locale; // en, ur, fa
  late bool darkMode;
  late double fontSize;
  late double arabicFontSize;
  late String reciterPreference;
  late bool notificationsEnabled;
  late bool azanNotifications;
  late bool eventNotifications;
  late double lastKnownLatitude;
  late double lastKnownLongitude;
  late String? lastKnownLocation;
  late DateTime settingsUpdateTime;
}

// ==================== CATEGORIES ====================

@collection
class Category {
  Id id = Isar.autoIncrement;

  late int categoryId;
  late String name;
  late String nameArabic;
  late String icon;
  late int order;
  late String type; // quran, duas, books, ziyaraat
}

// ==================== EVENTS ====================

@collection
class EventNotification {
  Id id = Isar.autoIncrement;

  late String eventName;
  late String eventNameArabic;
  late DateTime eventDate;
  late String description;
  late bool isHijriDate;
  late bool reminderEnabled;
  late DateTime? reminderTime;
  late String? relatedContent;
}

// ==================== PRAYER TIMES ====================

@collection
class PrayerTime {
  Id id = Isar.autoIncrement;

  late DateTime date;
  late String fajr;
  late String sunrise;
  late String dhuhr;
  late String asr;
  late String maghrib;
  late String isha;
  late String location;
  late DateTime lastUpdated;

  @Index()
  late DateTime dateIndex;
}

// ==================== DAILY DUA ====================

@collection
class DailyDua {
  Id id = Isar.autoIncrement;

  late DateTime date;
  late int duaId;
  late String duaTitle;
  late bool isRead;
}

// ==================== AAMAAL ====================

@collection
class Aamaal {
  Id id = Isar.autoIncrement;

  late String month;
  late int day;
  late String title;
  late String titleArabic;
  late String description;
  late String content;
  late String contentArabic;
  late String? contentUrdu;
  late String? contentFarsi;
}
