// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduled_stimulus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScheduledStimulus _$ScheduledStimulusFromJson(Map<String, dynamic> json) {
  return _ScheduledStimulus.fromJson(json);
}

/// @nodoc
mixin _$ScheduledStimulus {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  StimulusType get stimulusType => throw _privateConstructorUsedError;
  int get stimulusValue => throw _privateConstructorUsedError;
  DateTime get scheduledTime => throw _privateConstructorUsedError;
  bool get isRecurring => throw _privateConstructorUsedError;
  ScheduleRepeatUnit? get repeatUnit => throw _privateConstructorUsedError;
  int get repeatInterval => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get associatedHabitId => throw _privateConstructorUsedError;
  bool get executed => throw _privateConstructorUsedError;
  DateTime? get lastExecutedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ScheduledStimulus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduledStimulus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduledStimulusCopyWith<ScheduledStimulus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduledStimulusCopyWith<$Res> {
  factory $ScheduledStimulusCopyWith(
          ScheduledStimulus value, $Res Function(ScheduledStimulus) then) =
      _$ScheduledStimulusCopyWithImpl<$Res, ScheduledStimulus>;
  @useResult
  $Res call(
      {String id,
      String name,
      StimulusType stimulusType,
      int stimulusValue,
      DateTime scheduledTime,
      bool isRecurring,
      ScheduleRepeatUnit? repeatUnit,
      int repeatInterval,
      DateTime? endDate,
      bool isActive,
      String? associatedHabitId,
      bool executed,
      DateTime? lastExecutedAt,
      DateTime? createdAt});
}

/// @nodoc
class _$ScheduledStimulusCopyWithImpl<$Res, $Val extends ScheduledStimulus>
    implements $ScheduledStimulusCopyWith<$Res> {
  _$ScheduledStimulusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduledStimulus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? stimulusType = null,
    Object? stimulusValue = null,
    Object? scheduledTime = null,
    Object? isRecurring = null,
    Object? repeatUnit = freezed,
    Object? repeatInterval = null,
    Object? endDate = freezed,
    Object? isActive = null,
    Object? associatedHabitId = freezed,
    Object? executed = null,
    Object? lastExecutedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      stimulusType: null == stimulusType
          ? _value.stimulusType
          : stimulusType // ignore: cast_nullable_to_non_nullable
              as StimulusType,
      stimulusValue: null == stimulusValue
          ? _value.stimulusValue
          : stimulusValue // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      repeatUnit: freezed == repeatUnit
          ? _value.repeatUnit
          : repeatUnit // ignore: cast_nullable_to_non_nullable
              as ScheduleRepeatUnit?,
      repeatInterval: null == repeatInterval
          ? _value.repeatInterval
          : repeatInterval // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      associatedHabitId: freezed == associatedHabitId
          ? _value.associatedHabitId
          : associatedHabitId // ignore: cast_nullable_to_non_nullable
              as String?,
      executed: null == executed
          ? _value.executed
          : executed // ignore: cast_nullable_to_non_nullable
              as bool,
      lastExecutedAt: freezed == lastExecutedAt
          ? _value.lastExecutedAt
          : lastExecutedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduledStimulusImplCopyWith<$Res>
    implements $ScheduledStimulusCopyWith<$Res> {
  factory _$$ScheduledStimulusImplCopyWith(_$ScheduledStimulusImpl value,
          $Res Function(_$ScheduledStimulusImpl) then) =
      __$$ScheduledStimulusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      StimulusType stimulusType,
      int stimulusValue,
      DateTime scheduledTime,
      bool isRecurring,
      ScheduleRepeatUnit? repeatUnit,
      int repeatInterval,
      DateTime? endDate,
      bool isActive,
      String? associatedHabitId,
      bool executed,
      DateTime? lastExecutedAt,
      DateTime? createdAt});
}

/// @nodoc
class __$$ScheduledStimulusImplCopyWithImpl<$Res>
    extends _$ScheduledStimulusCopyWithImpl<$Res, _$ScheduledStimulusImpl>
    implements _$$ScheduledStimulusImplCopyWith<$Res> {
  __$$ScheduledStimulusImplCopyWithImpl(_$ScheduledStimulusImpl _value,
      $Res Function(_$ScheduledStimulusImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScheduledStimulus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? stimulusType = null,
    Object? stimulusValue = null,
    Object? scheduledTime = null,
    Object? isRecurring = null,
    Object? repeatUnit = freezed,
    Object? repeatInterval = null,
    Object? endDate = freezed,
    Object? isActive = null,
    Object? associatedHabitId = freezed,
    Object? executed = null,
    Object? lastExecutedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ScheduledStimulusImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      stimulusType: null == stimulusType
          ? _value.stimulusType
          : stimulusType // ignore: cast_nullable_to_non_nullable
              as StimulusType,
      stimulusValue: null == stimulusValue
          ? _value.stimulusValue
          : stimulusValue // ignore: cast_nullable_to_non_nullable
              as int,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRecurring: null == isRecurring
          ? _value.isRecurring
          : isRecurring // ignore: cast_nullable_to_non_nullable
              as bool,
      repeatUnit: freezed == repeatUnit
          ? _value.repeatUnit
          : repeatUnit // ignore: cast_nullable_to_non_nullable
              as ScheduleRepeatUnit?,
      repeatInterval: null == repeatInterval
          ? _value.repeatInterval
          : repeatInterval // ignore: cast_nullable_to_non_nullable
              as int,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      associatedHabitId: freezed == associatedHabitId
          ? _value.associatedHabitId
          : associatedHabitId // ignore: cast_nullable_to_non_nullable
              as String?,
      executed: null == executed
          ? _value.executed
          : executed // ignore: cast_nullable_to_non_nullable
              as bool,
      lastExecutedAt: freezed == lastExecutedAt
          ? _value.lastExecutedAt
          : lastExecutedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduledStimulusImpl extends _ScheduledStimulus {
  const _$ScheduledStimulusImpl(
      {required this.id,
      required this.name,
      required this.stimulusType,
      required this.stimulusValue,
      required this.scheduledTime,
      this.isRecurring = false,
      this.repeatUnit,
      this.repeatInterval = 1,
      this.endDate,
      this.isActive = true,
      this.associatedHabitId,
      this.executed = false,
      this.lastExecutedAt,
      this.createdAt})
      : super._();

  factory _$ScheduledStimulusImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduledStimulusImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final StimulusType stimulusType;
  @override
  final int stimulusValue;
  @override
  final DateTime scheduledTime;
  @override
  @JsonKey()
  final bool isRecurring;
  @override
  final ScheduleRepeatUnit? repeatUnit;
  @override
  @JsonKey()
  final int repeatInterval;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? associatedHabitId;
  @override
  @JsonKey()
  final bool executed;
  @override
  final DateTime? lastExecutedAt;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ScheduledStimulus(id: $id, name: $name, stimulusType: $stimulusType, stimulusValue: $stimulusValue, scheduledTime: $scheduledTime, isRecurring: $isRecurring, repeatUnit: $repeatUnit, repeatInterval: $repeatInterval, endDate: $endDate, isActive: $isActive, associatedHabitId: $associatedHabitId, executed: $executed, lastExecutedAt: $lastExecutedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledStimulusImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.stimulusType, stimulusType) ||
                other.stimulusType == stimulusType) &&
            (identical(other.stimulusValue, stimulusValue) ||
                other.stimulusValue == stimulusValue) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.repeatUnit, repeatUnit) ||
                other.repeatUnit == repeatUnit) &&
            (identical(other.repeatInterval, repeatInterval) ||
                other.repeatInterval == repeatInterval) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.associatedHabitId, associatedHabitId) ||
                other.associatedHabitId == associatedHabitId) &&
            (identical(other.executed, executed) ||
                other.executed == executed) &&
            (identical(other.lastExecutedAt, lastExecutedAt) ||
                other.lastExecutedAt == lastExecutedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      stimulusType,
      stimulusValue,
      scheduledTime,
      isRecurring,
      repeatUnit,
      repeatInterval,
      endDate,
      isActive,
      associatedHabitId,
      executed,
      lastExecutedAt,
      createdAt);

  /// Create a copy of ScheduledStimulus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduledStimulusImplCopyWith<_$ScheduledStimulusImpl> get copyWith =>
      __$$ScheduledStimulusImplCopyWithImpl<_$ScheduledStimulusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduledStimulusImplToJson(
      this,
    );
  }
}

abstract class _ScheduledStimulus extends ScheduledStimulus {
  const factory _ScheduledStimulus(
      {required final String id,
      required final String name,
      required final StimulusType stimulusType,
      required final int stimulusValue,
      required final DateTime scheduledTime,
      final bool isRecurring,
      final ScheduleRepeatUnit? repeatUnit,
      final int repeatInterval,
      final DateTime? endDate,
      final bool isActive,
      final String? associatedHabitId,
      final bool executed,
      final DateTime? lastExecutedAt,
      final DateTime? createdAt}) = _$ScheduledStimulusImpl;
  const _ScheduledStimulus._() : super._();

  factory _ScheduledStimulus.fromJson(Map<String, dynamic> json) =
      _$ScheduledStimulusImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  StimulusType get stimulusType;
  @override
  int get stimulusValue;
  @override
  DateTime get scheduledTime;
  @override
  bool get isRecurring;
  @override
  ScheduleRepeatUnit? get repeatUnit;
  @override
  int get repeatInterval;
  @override
  DateTime? get endDate;
  @override
  bool get isActive;
  @override
  String? get associatedHabitId;
  @override
  bool get executed;
  @override
  DateTime? get lastExecutedAt;
  @override
  DateTime? get createdAt;

  /// Create a copy of ScheduledStimulus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduledStimulusImplCopyWith<_$ScheduledStimulusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
