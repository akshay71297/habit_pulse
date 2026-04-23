import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_pulse/src/core/theme/app_theme.dart';
import 'package:habit_pulse/src/router/app_router.dart';
import 'package:habit_pulse/src/services/background_handler.dart';
import 'package:habit_pulse/src/services/background_task_service.dart';
import 'package:habit_pulse/src/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await BackgroundTaskService.initialize(callbackDispatcher);
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
