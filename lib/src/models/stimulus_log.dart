import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';

part 'stimulus_log.freezed.dart';
part 'stimulus_log.g.dart';

@freezed
class StimulusLog with _$StimulusLog {
  const factory StimulusLog({
    required String id,
    required StimulusType stimulusType,
    required int stimulusValue,
    required DateTime executedAt,
    @Default(true) bool success,
    String? errorMessage,
    String? habitId,
    String? scheduleId,
    @Default(false) bool fromOfflineQueue,
  }) = _StimulusLog;

  factory StimulusLog.fromJson(Map<String, Object?> json) =>
      _$StimulusLogFromJson(json);

  const StimulusLog._();

  factory StimulusLog.create({
    required StimulusType stimulusType,
    required int stimulusValue,
    bool success = true,
    String? errorMessage,
    String? habitId,
    String? scheduleId,
    bool fromOfflineQueue = false,
  }) {
    return StimulusLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      stimulusType: stimulusType,
      stimulusValue: stimulusValue,
      executedAt: DateTime.now().toUtc(),
      success: success,
      errorMessage: errorMessage,
      habitId: habitId,
      scheduleId: scheduleId,
      fromOfflineQueue: fromOfflineQueue,
    );
  }
}
