// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stimulus_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StimulusLog _$StimulusLogFromJson(Map<String, dynamic> json) {
  return _StimulusLog.fromJson(json);
}

/// @nodoc
mixin _$StimulusLog {
  String get id => throw _privateConstructorUsedError;
  StimulusType get stimulusType => throw _privateConstructorUsedError;
  int get stimulusValue => throw _privateConstructorUsedError;
  DateTime get executedAt => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get habitId => throw _privateConstructorUsedError;
  String? get scheduleId => throw _privateConstructorUsedError;
  bool get fromOfflineQueue => throw _privateConstructorUsedError;

  /// Serializes this StimulusLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StimulusLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StimulusLogCopyWith<StimulusLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StimulusLogCopyWith<$Res> {
  factory $StimulusLogCopyWith(
          StimulusLog value, $Res Function(StimulusLog) then) =
      _$StimulusLogCopyWithImpl<$Res, StimulusLog>;
  @useResult
  $Res call(
      {String id,
      StimulusType stimulusType,
      int stimulusValue,
      DateTime executedAt,
      bool success,
      String? errorMessage,
      String? habitId,
      String? scheduleId,
      bool fromOfflineQueue});
}

/// @nodoc
class _$StimulusLogCopyWithImpl<$Res, $Val extends StimulusLog>
    implements $StimulusLogCopyWith<$Res> {
  _$StimulusLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StimulusLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? stimulusType = null,
    Object? stimulusValue = null,
    Object? executedAt = null,
    Object? success = null,
    Object? errorMessage = freezed,
    Object? habitId = freezed,
    Object? scheduleId = freezed,
    Object? fromOfflineQueue = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      stimulusType: null == stimulusType
          ? _value.stimulusType
          : stimulusType // ignore: cast_nullable_to_non_nullable
              as StimulusType,
      stimulusValue: null == stimulusValue
          ? _value.stimulusValue
          : stimulusValue // ignore: cast_nullable_to_non_nullable
              as int,
      executedAt: null == executedAt
          ? _value.executedAt
          : executedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      habitId: freezed == habitId
          ? _value.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleId: freezed == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromOfflineQueue: null == fromOfflineQueue
          ? _value.fromOfflineQueue
          : fromOfflineQueue // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StimulusLogImplCopyWith<$Res>
    implements $StimulusLogCopyWith<$Res> {
  factory _$$StimulusLogImplCopyWith(
          _$StimulusLogImpl value, $Res Function(_$StimulusLogImpl) then) =
      __$$StimulusLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      StimulusType stimulusType,
      int stimulusValue,
      DateTime executedAt,
      bool success,
      String? errorMessage,
      String? habitId,
      String? scheduleId,
      bool fromOfflineQueue});
}

/// @nodoc
class __$$StimulusLogImplCopyWithImpl<$Res>
    extends _$StimulusLogCopyWithImpl<$Res, _$StimulusLogImpl>
    implements _$$StimulusLogImplCopyWith<$Res> {
  __$$StimulusLogImplCopyWithImpl(
      _$StimulusLogImpl _value, $Res Function(_$StimulusLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of StimulusLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? stimulusType = null,
    Object? stimulusValue = null,
    Object? executedAt = null,
    Object? success = null,
    Object? errorMessage = freezed,
    Object? habitId = freezed,
    Object? scheduleId = freezed,
    Object? fromOfflineQueue = null,
  }) {
    return _then(_$StimulusLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      stimulusType: null == stimulusType
          ? _value.stimulusType
          : stimulusType // ignore: cast_nullable_to_non_nullable
              as StimulusType,
      stimulusValue: null == stimulusValue
          ? _value.stimulusValue
          : stimulusValue // ignore: cast_nullable_to_non_nullable
              as int,
      executedAt: null == executedAt
          ? _value.executedAt
          : executedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      habitId: freezed == habitId
          ? _value.habitId
          : habitId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleId: freezed == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromOfflineQueue: null == fromOfflineQueue
          ? _value.fromOfflineQueue
          : fromOfflineQueue // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StimulusLogImpl extends _StimulusLog {
  const _$StimulusLogImpl(
      {required this.id,
      required this.stimulusType,
      required this.stimulusValue,
      required this.executedAt,
      this.success = true,
      this.errorMessage,
      this.habitId,
      this.scheduleId,
      this.fromOfflineQueue = false})
      : super._();

  factory _$StimulusLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$StimulusLogImplFromJson(json);

  @override
  final String id;
  @override
  final StimulusType stimulusType;
  @override
  final int stimulusValue;
  @override
  final DateTime executedAt;
  @override
  @JsonKey()
  final bool success;
  @override
  final String? errorMessage;
  @override
  final String? habitId;
  @override
  final String? scheduleId;
  @override
  @JsonKey()
  final bool fromOfflineQueue;

  @override
  String toString() {
    return 'StimulusLog(id: $id, stimulusType: $stimulusType, stimulusValue: $stimulusValue, executedAt: $executedAt, success: $success, errorMessage: $errorMessage, habitId: $habitId, scheduleId: $scheduleId, fromOfflineQueue: $fromOfflineQueue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StimulusLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.stimulusType, stimulusType) ||
                other.stimulusType == stimulusType) &&
            (identical(other.stimulusValue, stimulusValue) ||
                other.stimulusValue == stimulusValue) &&
            (identical(other.executedAt, executedAt) ||
                other.executedAt == executedAt) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.habitId, habitId) || other.habitId == habitId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.fromOfflineQueue, fromOfflineQueue) ||
                other.fromOfflineQueue == fromOfflineQueue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, stimulusType, stimulusValue,
      executedAt, success, errorMessage, habitId, scheduleId, fromOfflineQueue);

  /// Create a copy of StimulusLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StimulusLogImplCopyWith<_$StimulusLogImpl> get copyWith =>
      __$$StimulusLogImplCopyWithImpl<_$StimulusLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StimulusLogImplToJson(
      this,
    );
  }
}

abstract class _StimulusLog extends StimulusLog {
  const factory _StimulusLog(
      {required final String id,
      required final StimulusType stimulusType,
      required final int stimulusValue,
      required final DateTime executedAt,
      final bool success,
      final String? errorMessage,
      final String? habitId,
      final String? scheduleId,
      final bool fromOfflineQueue}) = _$StimulusLogImpl;
  const _StimulusLog._() : super._();

  factory _StimulusLog.fromJson(Map<String, dynamic> json) =
      _$StimulusLogImpl.fromJson;

  @override
  String get id;
  @override
  StimulusType get stimulusType;
  @override
  int get stimulusValue;
  @override
  DateTime get executedAt;
  @override
  bool get success;
  @override
  String? get errorMessage;
  @override
  String? get habitId;
  @override
  String? get scheduleId;
  @override
  bool get fromOfflineQueue;

  /// Create a copy of StimulusLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StimulusLogImplCopyWith<_$StimulusLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
