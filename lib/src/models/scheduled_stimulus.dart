import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';

part 'scheduled_stimulus.freezed.dart';
part 'scheduled_stimulus.g.dart';

@freezed
class ScheduledStimulus with _$ScheduledStimulus {
  const factory ScheduledStimulus({
    required String id,
    required String name,
    required StimulusType stimulusType,
    required int stimulusValue,
    required DateTime scheduledTime,
    @Default(false) bool isRecurring,
    ScheduleRepeatUnit? repeatUnit,
    @Default(1) int repeatInterval,
    DateTime? endDate,
    @Default(true) bool isActive,
    String? associatedHabitId,
    @Default(false) bool executed,
    DateTime? lastExecutedAt,
    DateTime? createdAt,
  }) = _ScheduledStimulus;

  factory ScheduledStimulus.fromJson(Map<String, Object?> json) =>
      _$ScheduledStimulusFromJson(json);

  const ScheduledStimulus._();

  factory ScheduledStimulus.create({
    required String name,
    required StimulusType stimulusType,
    required int stimulusValue,
    required DateTime scheduledTime,
    bool isRecurring = false,
    ScheduleRepeatUnit? repeatUnit,
    int repeatInterval = 1,
    DateTime? endDate,
    String? associatedHabitId,
  }) {
    final now = DateTime.now().toUtc();
    return ScheduledStimulus(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      stimulusType: stimulusType,
      stimulusValue: stimulusValue,
      scheduledTime: scheduledTime.toUtc(),
      isRecurring: isRecurring,
      repeatUnit: repeatUnit,
      repeatInterval: repeatInterval,
      endDate: endDate?.toUtc(),
      associatedHabitId: associatedHabitId,
      createdAt: now,
    );
  }

  DateTime? get nextOccurrence {
    if (!isRecurring || !isActive) return null;
    if (repeatUnit == null || repeatInterval <= 0) return null;

    final base = lastExecutedAt ?? scheduledTime;
    final duration = switch (repeatUnit!) {
      ScheduleRepeatUnit.minutes => Duration(minutes: repeatInterval),
      ScheduleRepeatUnit.hours => Duration(hours: repeatInterval),
      ScheduleRepeatUnit.days => Duration(days: repeatInterval),
    };

    var next = base.add(duration);
    while (next.isBefore(DateTime.now().toUtc())) {
      next = next.add(duration);
    }

    if (endDate != null && next.isAfter(endDate!)) return null;
    return next;
  }
}
