// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stimulus_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StimulusLogImpl _$$StimulusLogImplFromJson(Map<String, dynamic> json) =>
    _$StimulusLogImpl(
      id: json['id'] as String,
      stimulusType: $enumDecode(_$StimulusTypeEnumMap, json['stimulusType']),
      stimulusValue: (json['stimulusValue'] as num).toInt(),
      executedAt: DateTime.parse(json['executedAt'] as String),
      success: json['success'] as bool? ?? true,
      errorMessage: json['errorMessage'] as String?,
      habitId: json['habitId'] as String?,
      scheduleId: json['scheduleId'] as String?,
      fromOfflineQueue: json['fromOfflineQueue'] as bool? ?? false,
    );

Map<String, dynamic> _$$StimulusLogImplToJson(_$StimulusLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stimulusType': _$StimulusTypeEnumMap[instance.stimulusType]!,
      'stimulusValue': instance.stimulusValue,
      'executedAt': instance.executedAt.toIso8601String(),
      'success': instance.success,
      'errorMessage': instance.errorMessage,
      'habitId': instance.habitId,
      'scheduleId': instance.scheduleId,
      'fromOfflineQueue': instance.fromOfflineQueue,
    };

const _$StimulusTypeEnumMap = {
  StimulusType.zap: 'zap',
  StimulusType.vibe: 'vibe',
  StimulusType.beep: 'beep',
};
