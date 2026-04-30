import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/opening_clip/opening_clip_screen.dart';
import '../screens/home_screen.dart';
import '../screens/isal_e_sawab/isal_e_sawab_screen.dart';
import '../screens/quran/quran_screen.dart';
import '../screens/quran/surah_detail_screen.dart';
import '../screens/duas/duas_screen.dart';
import '../screens/duas/dua_detail_screen.dart';
import '../screens/books/books_screen.dart';
import '../screens/books/book_detail_screen.dart';
import '../screens/events/events_screen.dart';
import '../screens/live_ziyaraat/live_ziyaraat_screen.dart';
import '../screens/ziyaraat/ziyaraat_screen.dart';
import '../screens/ziyaraat/ziyarah_detail_screen.dart';
import '../screens/prayer_times/prayer_times_screen.dart';
import '../screens/qibla/qibla_screen.dart';
import '../screens/tasbeeh/tasbeeh_screen.dart';
import '../screens/bookmarks/bookmarks_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/audio_player/full_audio_player_screen.dart';
import '../screens/shrine_view/shrine_3d_view_screen.dart';
import '../screens/admin/admin_screen.dart';
import '../screens/admin/audio_manager_screen.dart';
import '../screens/admin/content_preview_screen.dart';
import '../screens/admin/library_screen.dart';
import '../screens/admin/upload_screen.dart';
import '../services/content_import_service.dart';
import '../widgets/sawab_ticker_bar.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/opening',
      builder: (context, state) => const OpeningClipScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => SawabTickerPageShell(child: child),
      routes: [
        GoRoute(
          path: '/quran',
          builder: (context, state) => const QuranScreen(),
        ),
        GoRoute(
          path: '/isal-e-sawab',
          builder: (context, state) => const IsalESawabScreen(),
        ),
        GoRoute(
          path: '/surah/:surahId',
          builder: (context, state) {
            final surahId = int.parse(state.pathParameters['surahId']!);
            return SurahDetailScreen(surahId: surahId);
          },
        ),
        GoRoute(
          path: '/duas',
          builder: (context, state) => const DuasScreen(),
        ),
        GoRoute(
          path: '/dua/:duaId',
          builder: (context, state) {
            final duaId = state.pathParameters['duaId']!;
            return DuaDetailScreen(duaId: duaId);
          },
        ),
        GoRoute(
          path: '/books',
          builder: (context, state) => const BooksScreen(),
        ),
        GoRoute(
          path: '/book/:bookId',
          builder: (context, state) {
            final bookId = state.pathParameters['bookId']!;
            return BookDetailScreen(bookId: bookId);
          },
        ),
        GoRoute(
          path: '/ziyaraat',
          builder: (context, state) => const ZiyaaratScreen(),
        ),
        GoRoute(
          path: '/events',
          builder: (context, state) => const EventsScreen(),
        ),
        GoRoute(
          path: '/live-ziyaraat',
          builder: (context, state) => const LiveZiyaraatScreen(),
        ),
        GoRoute(
          path: '/shrine-view/:shrineId',
          builder: (context, state) {
            final shrineId = state.pathParameters['shrineId']!;
            return Shrine3DViewScreen(shrineId: shrineId);
          },
        ),
        GoRoute(
          path: '/ziyarah/:ziyarahId',
          builder: (context, state) {
            final ziyarahId = state.pathParameters['ziyarahId']!;
            return ZiyarahDetailScreen(ziyarahId: ziyarahId);
          },
        ),
        GoRoute(
          path: '/prayer-times',
          builder: (context, state) => const PrayerTimesScreen(),
        ),
        GoRoute(
          path: '/qibla',
          builder: (context, state) => const QiblaScreen(),
        ),
        GoRoute(
          path: '/tasbeeh',
          builder: (context, state) => const TasbeehScreen(),
        ),
        GoRoute(
          path: '/bookmarks',
          builder: (context, state) => const BookmarksScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/player',
          builder: (context, state) => const FullAudioPlayerScreen(),
        ),
        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminScreen(),
        ),
        GoRoute(
          path: '/admin/upload',
          builder: (context, state) => const UploadScreen(),
        ),
        GoRoute(
          path: '/admin/library',
          builder: (context, state) => const AdminLibraryScreen(),
        ),
        GoRoute(
          path: '/admin/audio',
          builder: (context, state) => const AudioManagerScreen(),
        ),
        GoRoute(
          path: '/admin/preview',
          builder: (context, state) {
            final content = state.extra;
            if (content is UploadedContent) {
              return ContentPreviewScreen(content: content);
            }
            return const AdminLibraryScreen();
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(
      child: Text('Page not found: ${state.uri}'),
    ),
  ),
);
