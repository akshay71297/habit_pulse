import 'dart:io';
import 'dart:math';
import 'package:workmanager/workmanager.dart';
import 'package:habit_pulse/src/core/services/logger_service.dart';

const String _taskTag = 'habit_pulse_background';
const String _checkScheduledStimuliTask = 'check_scheduled_stimuli';

class BackgroundTaskService {
  static bool _initialized = false;

  static bool get isSupported => Platform.isAndroid || Platform.isIOS;

  static Future<void> initialize(Function backgroundHandler) async {
    if (_initialized || !isSupported) {
      if (!isSupported) {
        LoggerService.info('BackgroundTaskService: not supported on ${Platform.operatingSystem}, skipping');
      }
      return;
    }

    await Workmanager().initialize(
      backgroundHandler,
      isInDebugMode: false,
    );

    _initialized = true;
    LoggerService.info('BackgroundTaskService initialized');
  }

  static Future<void> registerPeriodicCheck() async {
    if (!isSupported) return;
    try {
      await Workmanager().registerPeriodicTask(
        _checkScheduledStimuliTask,
        _checkScheduledStimuliTask,
        frequency: const Duration(minutes: 15),
        constraints: Constraints(networkType: NetworkType.connected),
        existingWorkPolicy: ExistingWorkPolicy.keep,
        backoffPolicy: BackoffPolicy.exponential,
        backoffPolicyDelay: const Duration(minutes: 1),
        tag: _taskTag,
      );
      LoggerService.info('Registered periodic background task');
    } catch (e, st) {
      LoggerService.error('Failed to register background task', e, st);
    }
  }

  static Future<void> cancelAll() async {
    if (!isSupported) return;
    await Workmanager().cancelAll();
    LoggerService.info('Cancelled all background tasks');
  }

  /// Unique ID generator for one-off tasks.
  static String generateTaskId(String prefix) {
    return '${prefix}_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}';
  }
}
