// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pavlok_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PavlokSettingsImpl _$$PavlokSettingsImplFromJson(Map<String, dynamic> json) =>
    _$PavlokSettingsImpl(
      apiToken: json['apiToken'] as String,
      isEnabled: json['isEnabled'] as bool? ?? true,
      userEmail: json['userEmail'] as String?,
      lastTestedAt: json['lastTestedAt'] == null
          ? null
          : DateTime.parse(json['lastTestedAt'] as String),
      lastTestSuccess: json['lastTestSuccess'] as bool? ?? false,
      lastErrorMessage: json['lastErrorMessage'] as String?,
    );

Map<String, dynamic> _$$PavlokSettingsImplToJson(
        _$PavlokSettingsImpl instance) =>
    <String, dynamic>{
      'apiToken': instance.apiToken,
      'isEnabled': instance.isEnabled,
      'userEmail': instance.userEmail,
      'lastTestedAt': instance.lastTestedAt?.toIso8601String(),
      'lastTestSuccess': instance.lastTestSuccess,
      'lastErrorMessage': instance.lastErrorMessage,
    };
