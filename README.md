# Haqaiq - Islamic Mobile App

**Haqaiq** is a complete, production-ready Islamic mobile application featuring Quran, Duas, Books, Ziyaraat, Prayer Times, Tasbeeh Counter, Qibla Compass, and much more.

## Features

✨ **Core Features:**
- 📖 Complete Quran with Arabic text, English, Urdu, and Farsi translations
- 🤲 Major Duas (Kumail, Tawassul, Nudba, Ahad, Faraj)
- 📚 Islamic Books (Mafatih al-Jinan, Sahifa Sajjadiya, etc.)
- 🕌 Ziyaraat (Ashura, Warisa, Arbaeen, Imam Ali, etc.)
- ⏰ Prayer Times with API integration and offline caching
- 🧿 Tasbeeh Counter
- 🧭 Qibla Compass
- 📍 Prayer Compass with accurate calculations
- 🎙️ Professional Audio Player (Spotify-like)
- 🔔 Azan and Event Notifications
- 📱 Bookmarks and Favorites
- 🔍 Advanced Search
- 🌙 Dark/Light Theme
- 🌍 Multi-language Support (Urdu, English, Farsi)

## Technical Stack

- **Framework:** Flutter 3.x
- **State Management:** Riverpod
- **Navigation:** GoRouter
- **Database:** Isar (Offline SQLite)
- **Audio:** Just Audio + Audio Service
- **Notifications:** Flutter Local Notifications
- **Networking:** Dio
- **Serialization:** Freezed + JSON Serializable
- **Architecture:** Clean Architecture (MVVM)

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── constants/               # App colors, strings, constants
├── data/
│   ├── models/             # Isar database models
│   └── repositories/       # Data access layer
├── services/               # Business logic
│   ├── database_service.dart
│   ├── audio_player_service.dart
│   ├── notification_service.dart
│   ├── prayer_times_service.dart
│   └── ...
├── screens/                # UI screens
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── quran/
│   ├── duas/
│   ├── books/
│   ├── ziyaraat/
│   ├── prayer_times/
│   ├── qibla/
│   ├── tasbeeh/
│   ├── bookmarks/
│   ├── settings/
│   └── audio_player/
├── routes/                 # GoRouter navigation
└── assets/                # Images, fonts, JSON data
    ├── json/            # Content data
    ├── fonts/           # Custom fonts
    └── icons/           # Icons and images
```

## JSON Content Structure

All Islamic content is stored in JSON files under `assets/json/`:

- **quran.json** - All 114 Surahs with ayahs, translations, and audio
- **duas.json** - All duas with lines, translations, and audio
- **books.json** - Islamic books and sections
- **ziyaraat.json** - All ziyaraat and lines
- **categories.json** - Content categories
- **events.json** - Islamic events and occasions

## Installation & Setup

### Prerequisites
- Flutter SDK 3.x or higher
- Dart 3.x or higher
- Android Studio / Xcode
- Visual Studio Code (recommended)

### Steps

1. **Clone the repository:**
```bash
git clone https://github.com/yourusername/haqaiq.git
cd haqaiq_app
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Generate code files:**
```bash
flutter pub run build_runner build
```

4. **Run the app:**
```bash
flutter run
```

## Building for Production

### Android APK
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS App
```bash
flutter build ios --release
```

## Content Management

### Adding New Duas

Edit `assets/json/duas.json`:
```json
{
  "duas": [
    {
      "id": "dua_new",
      "titleAr": "دعاء جديد",
      "titleEn": "New Dua",
      "titleUr": "نئی دعا",
      "titleFa": "دعای جدید",
      "categoryId": "cat_duas_major",
      "description": "Description here",
      "order": 6
    }
  ],
  "duaLines": [
    {
      "id": "dua_new_line_1",
      "duaId": "dua_new",
      "lineNumber": 1,
      "arabicText": "النص العربي",
      "urduTranslation": "اردو ترجمہ",
      "englishTranslation": "English translation",
      "persianTranslation": "ترجمه فارسی",
      "transliteration": "Transliteration",
      "audioUrl": "https://example.com/audio.mp3",
      "localAudioPath": null,
      "startTime": 0.0,
      "endTime": 5.0,
      "order": 1
    }
  ]
}
```

### Adding Books

Edit `assets/json/books.json` following the same pattern.

### Adding Events

Edit `assets/json/events.json`:
```json
{
  "id": "event_id",
  "titleEn": "Event Name",
  "titleUr": "نام اردو",
  "titleFa": "نام فارسی",
  "descriptionEn": "Description",
  "descriptionUr": "تفصیل",
  "descriptionFa": "شرح",
  "eventDate": "2024-MM-DD",
  "isReminderSet": true
}
```

## Customization

### Change App Colors

Edit `lib/constants/app_colors.dart`:
```dart
static const Color primary = Color(0xFF1F4D3F); // Change to your color
```

### Change App Strings

Edit `lib/constants/app_strings.dart` to add translations for new languages.

### Add Custom Fonts

1. Add font files to `assets/fonts/`
2. Update `pubspec.yaml` fonts section
3. Reference in `lib/main.dart` AppTheme

## Prayer Times API

The app uses the **Aladhan API** for prayer time calculations:
```
https://api.aladhan.com/v1/timings/{date}
```

Parameters:
- `latitude` - User's latitude
- `longitude` - User's longitude  
- `method` - 5 (Shia method)
- `school` - 1 (Shia school)

## Notifications

### Setup Azan Notifications
1. Initialize in main()
2. Schedule notifications using PrayerTimesService
3. Handle tap events in notification_service.dart

### Push Notifications
- Integrate Firebase Cloud Messaging (optional)
- Implement custom notification handling

## Database Schema

### Quran Table
- surahId, surahNumber, arabicText, translations, juzNumber

### Dua Table  
- duaId, titleAr/En/Ur/Fa, categoryId, isFavorite, lastReadAt

### Bookmark Table
- bookmarkId, contentId, contentType, title, createdAt

### ReadingProgress Table
- progressId, contentId, currentLineNumber, scrollOffset

## Audio Implementation

### Audio Playback
```dart
final audioService = AudioPlayerService.instance;
await audioService.loadAudio('https://example.com/audio.mp3');
await audioService.play();
await audioService.setSpeed(1.5); // 1.5x speed
```

### Download Audio
```dart
await audioService.downloadAudio(
  'https://example.com/audio.mp3',
  '/path/to/save'
);
```

## Offline Functionality

1. All content is seeded from JSON on first launch
2. Audio files are cached locally when downloaded
3. Prayer times are cached for 24 hours
4. Complete offline access after initial setup

## Testing

```bash
flutter test
```

## Performance Optimization

- Lazy load content
- Paginate long lists
- Use efficient JSON parsing
- Cache frequently accessed data
- Implement image optimization

## Troubleshooting

### Database Issues
```bash
flutter clean
rm -rf build ios android
flutter pub get
flutter run
```

### Build Issues
```bash
flutter pub cache clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit changes
4. Push to branch
5. Open a Pull Request

## License

This project is licensed under the MIT License.

## Credits

- Content sources: Public Islamic repositories
- Audio: Licensed Islamic recordings
- Translations: Verified Islamic scholars

## Support

For issues and feature requests, please open an issue on GitHub.

## Roadmap

- [ ] Firebase Integration
- [ ] Cloud Sync
- [ ] Community Features
- [ ] Advanced Search
- [ ] Dark Mode Theme
- [ ] Persian Keyboard
- [ ] Offline Maps
- [ ] Live Streaming Events

## Version History

**v1.0.0** (2024)
- Initial release
- Complete Quran
- All major duas
- Prayer times
- Notifications
- Multi-language support

---

**Made with ❤️ for the Islamic Community**

*Haqaiq - Your Islamic Digital Companion*
