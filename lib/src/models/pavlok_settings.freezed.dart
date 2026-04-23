// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pavlok_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PavlokSettings _$PavlokSettingsFromJson(Map<String, dynamic> json) {
  return _PavlokSettings.fromJson(json);
}

/// @nodoc
mixin _$PavlokSettings {
  String get apiToken => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;
  String? get userEmail => throw _privateConstructorUsedError;
  DateTime? get lastTestedAt => throw _privateConstructorUsedError;
  bool get lastTestSuccess => throw _privateConstructorUsedError;
  String? get lastErrorMessage => throw _privateConstructorUsedError;

  /// Serializes this PavlokSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PavlokSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PavlokSettingsCopyWith<PavlokSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PavlokSettingsCopyWith<$Res> {
  factory $PavlokSettingsCopyWith(
          PavlokSettings value, $Res Function(PavlokSettings) then) =
      _$PavlokSettingsCopyWithImpl<$Res, PavlokSettings>;
  @useResult
  $Res call(
      {String apiToken,
      bool isEnabled,
      String? userEmail,
      DateTime? lastTestedAt,
      bool lastTestSuccess,
      String? lastErrorMessage});
}

/// @nodoc
class _$PavlokSettingsCopyWithImpl<$Res, $Val extends PavlokSettings>
    implements $PavlokSettingsCopyWith<$Res> {
  _$PavlokSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PavlokSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiToken = null,
    Object? isEnabled = null,
    Object? userEmail = freezed,
    Object? lastTestedAt = freezed,
    Object? lastTestSuccess = null,
    Object? lastErrorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      apiToken: null == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      lastTestedAt: freezed == lastTestedAt
          ? _value.lastTestedAt
          : lastTestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastTestSuccess: null == lastTestSuccess
          ? _value.lastTestSuccess
          : lastTestSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      lastErrorMessage: freezed == lastErrorMessage
          ? _value.lastErrorMessage
          : lastErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PavlokSettingsImplCopyWith<$Res>
    implements $PavlokSettingsCopyWith<$Res> {
  factory _$$PavlokSettingsImplCopyWith(_$PavlokSettingsImpl value,
          $Res Function(_$PavlokSettingsImpl) then) =
      __$$PavlokSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String apiToken,
      bool isEnabled,
      String? userEmail,
      DateTime? lastTestedAt,
      bool lastTestSuccess,
      String? lastErrorMessage});
}

/// @nodoc
class __$$PavlokSettingsImplCopyWithImpl<$Res>
    extends _$PavlokSettingsCopyWithImpl<$Res, _$PavlokSettingsImpl>
    implements _$$PavlokSettingsImplCopyWith<$Res> {
  __$$PavlokSettingsImplCopyWithImpl(
      _$PavlokSettingsImpl _value, $Res Function(_$PavlokSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PavlokSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiToken = null,
    Object? isEnabled = null,
    Object? userEmail = freezed,
    Object? lastTestedAt = freezed,
    Object? lastTestSuccess = null,
    Object? lastErrorMessage = freezed,
  }) {
    return _then(_$PavlokSettingsImpl(
      apiToken: null == apiToken
          ? _value.apiToken
          : apiToken // ignore: cast_nullable_to_non_nullable
              as String,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      lastTestedAt: freezed == lastTestedAt
          ? _value.lastTestedAt
          : lastTestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastTestSuccess: null == lastTestSuccess
          ? _value.lastTestSuccess
          : lastTestSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      lastErrorMessage: freezed == lastErrorMessage
          ? _value.lastErrorMessage
          : lastErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PavlokSettingsImpl implements _PavlokSettings {
  const _$PavlokSettingsImpl(
      {required this.apiToken,
      this.isEnabled = true,
      this.userEmail,
      this.lastTestedAt,
      this.lastTestSuccess = false,
      this.lastErrorMessage});

  factory _$PavlokSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PavlokSettingsImplFromJson(json);

  @override
  final String apiToken;
  @override
  @JsonKey()
  final bool isEnabled;
  @override
  final String? userEmail;
  @override
  final DateTime? lastTestedAt;
  @override
  @JsonKey()
  final bool lastTestSuccess;
  @override
  final String? lastErrorMessage;

  @override
  String toString() {
    return 'PavlokSettings(apiToken: $apiToken, isEnabled: $isEnabled, userEmail: $userEmail, lastTestedAt: $lastTestedAt, lastTestSuccess: $lastTestSuccess, lastErrorMessage: $lastErrorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PavlokSettingsImpl &&
            (identical(other.apiToken, apiToken) ||
                other.apiToken == apiToken) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.lastTestedAt, lastTestedAt) ||
                other.lastTestedAt == lastTestedAt) &&
            (identical(other.lastTestSuccess, lastTestSuccess) ||
                other.lastTestSuccess == lastTestSuccess) &&
            (identical(other.lastErrorMessage, lastErrorMessage) ||
                other.lastErrorMessage == lastErrorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, apiToken, isEnabled, userEmail,
      lastTestedAt, lastTestSuccess, lastErrorMessage);

  /// Create a copy of PavlokSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PavlokSettingsImplCopyWith<_$PavlokSettingsImpl> get copyWith =>
      __$$PavlokSettingsImplCopyWithImpl<_$PavlokSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PavlokSettingsImplToJson(
      this,
    );
  }
}

abstract class _PavlokSettings implements PavlokSettings {
  const factory _PavlokSettings(
      {required final String apiToken,
      final bool isEnabled,
      final String? userEmail,
      final DateTime? lastTestedAt,
      final bool lastTestSuccess,
      final String? lastErrorMessage}) = _$PavlokSettingsImpl;

  factory _PavlokSettings.fromJson(Map<String, dynamic> json) =
      _$PavlokSettingsImpl.fromJson;

  @override
  String get apiToken;
  @override
  bool get isEnabled;
  @override
  String? get userEmail;
  @override
  DateTime? get lastTestedAt;
  @override
  bool get lastTestSuccess;
  @override
  String? get lastErrorMessage;

  /// Create a copy of PavlokSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PavlokSettingsImplCopyWith<_$PavlokSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
