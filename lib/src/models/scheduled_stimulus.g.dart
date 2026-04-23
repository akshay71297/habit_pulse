// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_stimulus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduledStimulusImpl _$$ScheduledStimulusImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduledStimulusImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      stimulusType: $enumDecode(_$StimulusTypeEnumMap, json['stimulusType']),
      stimulusValue: (json['stimulusValue'] as num).toInt(),
      scheduledTime: DateTime.parse(json['scheduledTime'] as String),
      isRecurring: json['isRecurring'] as bool? ?? false,
      repeatUnit:
          $enumDecodeNullable(_$ScheduleRepeatUnitEnumMap, json['repeatUnit']),
      repeatInterval: (json['repeatInterval'] as num?)?.toInt() ?? 1,
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
      associatedHabitId: json['associatedHabitId'] as String?,
      executed: json['executed'] as bool? ?? false,
      lastExecutedAt: json['lastExecutedAt'] == null
          ? null
          : DateTime.parse(json['lastExecutedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ScheduledStimulusImplToJson(
        _$ScheduledStimulusImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stimulusType': _$StimulusTypeEnumMap[instance.stimulusType]!,
      'stimulusValue': instance.stimulusValue,
      'scheduledTime': instance.scheduledTime.toIso8601String(),
      'isRecurring': instance.isRecurring,
      'repeatUnit': _$ScheduleRepeatUnitEnumMap[instance.repeatUnit],
      'repeatInterval': instance.repeatInterval,
      'endDate': instance.endDate?.toIso8601String(),
      'isActive': instance.isActive,
      'associatedHabitId': instance.associatedHabitId,
      'executed': instance.executed,
      'lastExecutedAt': instance.lastExecutedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$StimulusTypeEnumMap = {
  StimulusType.zap: 'zap',
  StimulusType.vibrate: 'vibrate',
  StimulusType.beep: 'beep',
};

const _$ScheduleRepeatUnitEnumMap = {
  ScheduleRepeatUnit.minutes: 'minutes',
  ScheduleRepeatUnit.hours: 'hours',
  ScheduleRepeatUnit.days: 'days',
};
