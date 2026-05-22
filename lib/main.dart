import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';
import 'services/app_theme_service.dart';
import 'services/event_notification_service.dart';
import 'services/islamic_event_calendar_service.dart';
import 'services/notification_service.dart';
import 'services/prayer_times_service.dart';
import 'constants/app_colors.dart';
import 'widgets/exit_confirmation_scope.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppThemeService.instance.initialize();

  runApp(const ProviderScope(child: MyApp()));

  Timer.periodic(const Duration(minutes: 30), (_) {
    unawaited(AppThemeService.instance.refreshEventMood());
  });
  unawaited(_initializeAfterFirstFrame());
}

Future<void> _initializeAfterFirstFrame() async {
  await Future<void>.delayed(const Duration(seconds: 10));

  try {
    await NotificationService().initialize();
  } catch (_) {}
  try {
    await PrayerTimesService().ensurePrayerNotificationsScheduled();
  } catch (_) {}
  try {
    await EventNotificationService().scheduleUpcomingEventNotifications();
  } catch (_) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppThemeService.instance.mode,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder<EventThemeMood>(
          valueListenable: AppThemeService.instance.eventMood,
          builder: (context, eventMood, _) {
            final effectiveThemeMode = switch (eventMood) {
              EventThemeMood.mourning => ThemeMode.dark,
              EventThemeMood.celebration => ThemeMode.light,
              EventThemeMood.normal => themeMode,
            };

            return MaterialApp.router(
              title: 'Haqaiq - Islamic App',
              theme: eventMood == EventThemeMood.celebration
                  ? _celebrationTheme()
                  : _lightTheme(),
              darkTheme: eventMood == EventThemeMood.mourning
                  ? _mourningTheme()
                  : _darkTheme(),
              themeMode: effectiveThemeMode,
              routerConfig: appRouter,
              builder: (context, child) {
                return ExitConfirmationScope(
                  router: appRouter,
                  child: child ?? const SizedBox.shrink(),
                );
              },
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      primaryColor: AppColors.primary,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFAFAF7),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      primaryColor: AppColors.primary,
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF101614),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        surface: const Color(0xFF17211E),
      ),
      cardTheme: const CardThemeData(
        color: Color(0xFF17211E),
        surfaceTintColor: Colors.transparent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF101614),
        foregroundColor: Colors.white,
      ),
    );
  }

  ThemeData _mourningTheme() {
    return ThemeData(
      primaryColor: const Color(0xFF242424),
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF070707),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF424242),
        brightness: Brightness.dark,
        primary: const Color(0xFFE0E0E0),
        surface: const Color(0xFF111111),
      ),
      cardTheme: const CardThemeData(
        color: Color(0xFF141414),
        surfaceTintColor: Colors.transparent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF070707),
        foregroundColor: Colors.white,
      ),
    );
  }

  ThemeData _celebrationTheme() {
    return ThemeData(
      primaryColor: const Color(0xFF0D8B57),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFFFBF0),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD8A72E),
        brightness: Brightness.light,
        primary: const Color(0xFF0D8B57),
        secondary: const Color(0xFFD8A72E),
        surface: Colors.white,
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0D8B57),
        foregroundColor: Colors.white,
      ),
    );
  }
}
