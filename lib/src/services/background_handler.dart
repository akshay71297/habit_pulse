import 'package:workmanager/workmanager.dart';
import 'package:habit_pulse/src/core/services/logger_service.dart';
import 'package:habit_pulse/src/database/database_helper.dart';
import 'package:habit_pulse/src/database/scheduled_stimulus_dao.dart';
import 'package:habit_pulse/src/database/settings_dao.dart';
import 'package:habit_pulse/src/database/stimulus_log_dao.dart';
import 'package:habit_pulse/src/models/stimulus_log.dart';
import 'package:habit_pulse/src/services/notification_service.dart';
import 'package:habit_pulse/src/services/pavlok_api_service.dart';

/// Top-level callback required by Workmanager.
/// Must be a global or static function.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    LoggerService.info('Background task started: $task');

    try {
      await NotificationService.initialize();

      final db = DatabaseHelper.instance;
      final settingsDao = SettingsDao(db);
      final scheduledDao = ScheduledStimulusDao(db);
      final logDao = StimulusLogDao(db);

      final settings = await settingsDao.getSettings();
      if (settings == null || settings.apiToken.isEmpty) {
        LoggerService.warning('Background task: no API token');
        return true;
      }

      final api = PavlokApiService();
      api.updateSettings(settings);

      final pending = await scheduledDao.getPendingBefore(DateTime.now().toUtc());
      LoggerService.info('Background task: ${pending.length} pending stimuli');

      for (final stimulus in pending) {
        final result = await api.sendStimulus(
          type: stimulus.stimulusType,
          value: stimulus.stimulusValue,
          scheduleId: stimulus.id,
        );

        final success = result is PavlokSuccess;
        final log = StimulusLog.create(
          stimulusType: stimulus.stimulusType,
          stimulusValue: stimulus.stimulusValue,
          success: success,
          errorMessage: success ? null : (result as PavlokError).message,
          scheduleId: stimulus.id,
          fromOfflineQueue: false,
        );
        await logDao.insert(log);

        if (success) {
          await NotificationService.showImmediate(
            title: 'Scheduled Stimulus Sent',
            body: '${stimulus.stimulusType.name.toUpperCase()} at ${stimulus.stimulusValue}',
          );
        }

        final next = stimulus.nextOccurrence;
        if (stimulus.isRecurring && next != null) {
          await scheduledDao.markExecuted(stimulus.id, nextTime: next);
        } else {
          await scheduledDao.markExecuted(stimulus.id);
        }
      }

      LoggerService.info('Background task completed successfully');
      return true;
    } catch (e, st) {
      LoggerService.error('Background task failed', e, st);
      return true; // Returning false may cause Workmanager to retry aggressively.
    }
  });
}
