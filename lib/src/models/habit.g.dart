// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HabitImpl _$$HabitImplFromJson(Map<String, dynamic> json) => _$HabitImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$HabitTypeEnumMap, json['type']),
      isActive: json['isActive'] as bool? ?? false,
      pavlokStimulusType: json['pavlokStimulusType'] as String?,
      stimulusValue: (json['stimulusValue'] as num?)?.toInt() ?? 50,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      bestStreak: (json['bestStreak'] as num?)?.toInt() ?? 0,
      totalCompletions: (json['totalCompletions'] as num?)?.toInt() ?? 0,
      lastCompletedAt: json['lastCompletedAt'] == null
          ? null
          : DateTime.parse(json['lastCompletedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$HabitImplToJson(_$HabitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$HabitTypeEnumMap[instance.type]!,
      'isActive': instance.isActive,
      'pavlokStimulusType': instance.pavlokStimulusType,
      'stimulusValue': instance.stimulusValue,
      'currentStreak': instance.currentStreak,
      'bestStreak': instance.bestStreak,
      'totalCompletions': instance.totalCompletions,
      'lastCompletedAt': instance.lastCompletedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$HabitTypeEnumMap = {
  HabitType.good: 'good',
  HabitType.bad: 'bad',
};
