// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Habit _$HabitFromJson(Map<String, dynamic> json) {
  return _Habit.fromJson(json);
}

/// @nodoc
mixin _$Habit {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  HabitType get type => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get pavlokStimulusType => throw _privateConstructorUsedError;
  int get stimulusValue => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get bestStreak => throw _privateConstructorUsedError;
  int get totalCompletions => throw _privateConstructorUsedError;
  DateTime? get lastCompletedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Habit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HabitCopyWith<Habit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitCopyWith<$Res> {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) then) =
      _$HabitCopyWithImpl<$Res, Habit>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      HabitType type,
      bool isActive,
      String? pavlokStimulusType,
      int stimulusValue,
      int currentStreak,
      int bestStreak,
      int totalCompletions,
      DateTime? lastCompletedAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$HabitCopyWithImpl<$Res, $Val extends Habit>
    implements $HabitCopyWith<$Res> {
  _$HabitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? isActive = null,
    Object? pavlokStimulusType = freezed,
    Object? stimulusValue = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? totalCompletions = null,
    Object? lastCompletedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HabitType,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      pavlokStimulusType: freezed == pavlokStimulusType
          ? _value.pavlokStimulusType
          : pavlokStimulusType // ignore: cast_nullable_to_non_nullable
              as String?,
      stimulusValue: null == stimulusValue
          ? _value.stimulusValue
          : stimulusValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalCompletions: null == totalCompletions
          ? _value.totalCompletions
          : totalCompletions // ignore: cast_nullable_to_non_nullable
              as int,
      lastCompletedAt: freezed == lastCompletedAt
          ? _value.lastCompletedAt
          : lastCompletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HabitImplCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$$HabitImplCopyWith(
          _$HabitImpl value, $Res Function(_$HabitImpl) then) =
      __$$HabitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      HabitType type,
      bool isActive,
      String? pavlokStimulusType,
      int stimulusValue,
      int currentStreak,
      int bestStreak,
      int totalCompletions,
      DateTime? lastCompletedAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$HabitImplCopyWithImpl<$Res>
    extends _$HabitCopyWithImpl<$Res, _$HabitImpl>
    implements _$$HabitImplCopyWith<$Res> {
  __$$HabitImplCopyWithImpl(
      _$HabitImpl _value, $Res Function(_$HabitImpl) _then)
      : super(_value, _then);

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? type = null,
    Object? isActive = null,
    Object? pavlokStimulusType = freezed,
    Object? stimulusValue = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? totalCompletions = null,
    Object? lastCompletedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$HabitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as HabitType,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      pavlokStimulusType: freezed == pavlokStimulusType
          ? _value.pavlokStimulusType
          : pavlokStimulusType // ignore: cast_nullable_to_non_nullable
              as String?,
      stimulusValue: null == stimulusValue
          ? _value.stimulusValue
          : stimulusValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalCompletions: null == totalCompletions
          ? _value.totalCompletions
          : totalCompletions // ignore: cast_nullable_to_non_nullable
              as int,
      lastCompletedAt: freezed == lastCompletedAt
          ? _value.lastCompletedAt
          : lastCompletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HabitImpl extends _Habit {
  const _$HabitImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.type,
      this.isActive = false,
      this.pavlokStimulusType,
      this.stimulusValue = 50,
      this.currentStreak = 0,
      this.bestStreak = 0,
      this.totalCompletions = 0,
      this.lastCompletedAt,
      this.createdAt,
      this.updatedAt})
      : super._();

  factory _$HabitImpl.fromJson(Map<String, dynamic> json) =>
      _$$HabitImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final HabitType type;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? pavlokStimulusType;
  @override
  @JsonKey()
  final int stimulusValue;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int bestStreak;
  @override
  @JsonKey()
  final int totalCompletions;
  @override
  final DateTime? lastCompletedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Habit(id: $id, name: $name, description: $description, type: $type, isActive: $isActive, pavlokStimulusType: $pavlokStimulusType, stimulusValue: $stimulusValue, currentStreak: $currentStreak, bestStreak: $bestStreak, totalCompletions: $totalCompletions, lastCompletedAt: $lastCompletedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.pavlokStimulusType, pavlokStimulusType) ||
                other.pavlokStimulusType == pavlokStimulusType) &&
            (identical(other.stimulusValue, stimulusValue) ||
                other.stimulusValue == stimulusValue) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestStreak, bestStreak) ||
                other.bestStreak == bestStreak) &&
            (identical(other.totalCompletions, totalCompletions) ||
                other.totalCompletions == totalCompletions) &&
            (identical(other.lastCompletedAt, lastCompletedAt) ||
                other.lastCompletedAt == lastCompletedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      type,
      isActive,
      pavlokStimulusType,
      stimulusValue,
      currentStreak,
      bestStreak,
      totalCompletions,
      lastCompletedAt,
      createdAt,
      updatedAt);

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitImplCopyWith<_$HabitImpl> get copyWith =>
      __$$HabitImplCopyWithImpl<_$HabitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HabitImplToJson(
      this,
    );
  }
}

abstract class _Habit extends Habit {
  const factory _Habit(
      {required final String id,
      required final String name,
      required final String description,
      required final HabitType type,
      final bool isActive,
      final String? pavlokStimulusType,
      final int stimulusValue,
      final int currentStreak,
      final int bestStreak,
      final int totalCompletions,
      final DateTime? lastCompletedAt,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$HabitImpl;
  const _Habit._() : super._();

  factory _Habit.fromJson(Map<String, dynamic> json) = _$HabitImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  HabitType get type;
  @override
  bool get isActive;
  @override
  String? get pavlokStimulusType;
  @override
  int get stimulusValue;
  @override
  int get currentStreak;
  @override
  int get bestStreak;
  @override
  int get totalCompletions;
  @override
  DateTime? get lastCompletedAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Habit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitImplCopyWith<_$HabitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
