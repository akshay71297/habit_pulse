import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_pulse/src/core/theme/app_theme.dart';
import 'package:habit_pulse/src/database/database_helper.dart';
import 'package:habit_pulse/src/database/settings_dao.dart';
import 'package:habit_pulse/src/router/app_router.dart';
import 'package:habit_pulse/src/services/background_handler.dart';
import 'package:habit_pulse/src/services/background_task_service.dart';
import 'package:habit_pulse/src/services/notification_service.dart';
import 'package:habit_pulse/src/services/widget_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _syncTokenToPrefs() async {
  try {
    final db = DatabaseHelper.instance;
    final dao = SettingsDao(db);
    final settings = await dao.getSettings();
    if (settings != null && settings.apiToken.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('pavlok_api_token', settings.apiToken);
    }
  } catch (_) {
    // Silently fail; widget falls back to reading SQLite directly
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await BackgroundTaskService.initialize(callbackDispatcher);
  await WidgetService.initialize();
  await _syncTokenToPrefs();
  runApp(const ProviderScope(child: HabitPulseApp()));
}

class HabitPulseApp extends StatelessWidget {
  const HabitPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HabitPulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
    );
  }
}
