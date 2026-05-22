import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'islamic_event_calendar_service.dart';

class AppThemeService {
  AppThemeService._();

  static final AppThemeService instance = AppThemeService._();
  static const String _prefsKey = 'app_theme_mode';

  final ValueNotifier<ThemeMode> mode = ValueNotifier<ThemeMode>(
    ThemeMode.light,
  );
  final ValueNotifier<EventThemeMood> eventMood =
      ValueNotifier<EventThemeMood>(EventThemeMood.normal);

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    mode.value = _themeModeFromName(prefs.getString(_prefsKey));
    await refreshEventMood();
  }

  Future<void> setMode(ThemeMode themeMode) async {
    mode.value = themeMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, themeMode.name);
  }

  Future<void> refreshEventMood() async {
    try {
      eventMood.value = await IslamicEventCalendarService.instance
          .moodForLocalDate(DateTime.now());
    } catch (_) {
      eventMood.value = EventThemeMood.normal;
    }
  }

  ThemeMode _themeModeFromName(String? value) {
    return switch (value) {
      'dark' => ThemeMode.dark,
      _ => ThemeMode.light,
    };
  }
}
