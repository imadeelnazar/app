import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';
import 'services/database/database_service.dart';
import 'services/audio_player_service.dart';
import 'services/notification_service.dart';
import 'services/prayer_times_service.dart';
import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await DatabaseService.initialize();
  } catch (_) {}
  try {
    await AudioPlayerService().initialize();
  } catch (_) {}
  try {
    await NotificationService().initialize();
  } catch (_) {}
  try {
    PrayerTimesService();
  } catch (_) {}

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hidayat - Islamic App',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: AppColors.primary,
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
