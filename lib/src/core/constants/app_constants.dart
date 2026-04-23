/// Core application constants.
library;

class AppConstants {
  AppConstants._();

  static const String appName = 'HabitPulse';
  static const String appVersion = '1.0.0';

  // Database
  static const String dbName = 'habit_pulse.db';
  static const int dbVersion = 1;

  // Pavlok API
  static const String pavlokBaseUrl = 'https://api.pavlok.com/api/v5';
  static const int pavlokConnectTimeoutMs = 15000;
  static const int pavlokReceiveTimeoutMs = 15000;
  static const int pavlokMaxRetries = 3;

  // Stimulus limits
  static const int minStimulusValue = 0;
  static const int maxStimulusValue = 100;
  static const int defaultStimulusValue = 50;

  // Scheduling
  static const int maxScheduledTasks = 100;
  static const Duration backgroundTaskFrequency = Duration(minutes: 15);
}

enum StimulusType { zap, vibrate, beep }

enum HabitType { good, bad }

enum ScheduleRepeatUnit { minutes, hours, days }
