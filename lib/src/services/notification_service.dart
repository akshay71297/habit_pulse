import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_pulse/src/core/services/logger_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();

    final settings = InitializationSettings(
      android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: const DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
      linux: Platform.isLinux
          ? LinuxInitializationSettings(
              defaultActionName: 'Open',
              defaultIcon: AssetsLinuxIcon('assets/app_icon.png'),
            )
          : null,
    );

    try {
      await _plugin.initialize(
        settings,
        onDidReceiveNotificationResponse: _onNotificationTap,
      );
      _initialized = true;
      LoggerService.info('NotificationService initialized');
    } catch (e) {
      LoggerService.warning('NotificationService init failed (non-critical): $e');
    }
  }

  static Future<bool> requestPermissions() async {
    final result = await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    return result ?? true;
  }

  static Future<void> showImmediate({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_initialized) return;
    await _plugin.show(
      DateTime.now().millisecond,
      title,
      body,
      _notificationDetails(),
      payload: payload,
    );
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    if (!_initialized) return;
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  static Future<void> cancel(int id) async {
    if (!_initialized) return;
    await _plugin.cancel(id);
  }

  static Future<void> cancelAll() async {
    if (!_initialized) return;
    await _plugin.cancelAll();
  }

  static NotificationDetails _notificationDetails() {
    const androidChannel = AndroidNotificationChannel(
      'habit_pulse_channel',
      'HabitPulse',
      importance: Importance.high,
      playSound: true,
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        androidChannel.id,
        androidChannel.name,
        channelDescription: 'Habit and stimulus notifications',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
      linux: const LinuxNotificationDetails(),
    );
  }

  static void _onNotificationTap(NotificationResponse response) {
    LoggerService.info('Notification tapped: ${response.payload}');
  }
}
