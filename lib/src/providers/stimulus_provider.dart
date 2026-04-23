import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/database/stimulus_log_dao.dart';
import 'package:habit_pulse/src/models/stimulus_log.dart';
import 'package:habit_pulse/src/providers/database_providers.dart';
import 'package:habit_pulse/src/providers/settings_provider.dart';
import 'package:habit_pulse/src/services/notification_service.dart';
import 'package:habit_pulse/src/services/pavlok_api_service.dart';

class StimulusNotifier extends StateNotifier<AsyncValue<void>> {
  final PavlokApiService _api;
  final StimulusLogDao _logDao;

  StimulusNotifier(this._api, this._logDao) : super(const AsyncValue.data(null));

  Future<void> send({
    required StimulusType type,
    required int value,
    String? habitId,
    String? scheduleId,
  }) async {
    state = const AsyncValue.loading();

    final result = await _api.sendStimulus(
      type: type,
      value: value,
      habitId: habitId,
      scheduleId: scheduleId,
    );

    switch (result) {
      case PavlokSuccess():
        final log = StimulusLog.create(
          stimulusType: type,
          stimulusValue: value,
          habitId: habitId,
          scheduleId: scheduleId,
        );
        await _logDao.insert(log);
        await NotificationService.showImmediate(
          title: 'Stimulus Sent',
          body: '${type.name.toUpperCase()} delivered at intensity $value',
        );
        state = const AsyncValue.data(null);
      case PavlokError(:final message, :final isRetryable):
        final log = StimulusLog.create(
          stimulusType: type,
          stimulusValue: value,
          success: false,
          errorMessage: message,
          habitId: habitId,
          scheduleId: scheduleId,
          fromOfflineQueue: isRetryable,
        );
        await _logDao.insert(log);
        state = AsyncValue.error(message, StackTrace.current);
    }
  }
}

final stimulusNotifierProvider = StateNotifierProvider<StimulusNotifier, AsyncValue<void>>((ref) {
  return StimulusNotifier(
    ref.watch(pavlokApiServiceProvider),
    ref.watch(stimulusLogDaoProvider),
  );
});
