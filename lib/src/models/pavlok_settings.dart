import 'package:freezed_annotation/freezed_annotation.dart';

part 'pavlok_settings.freezed.dart';
part 'pavlok_settings.g.dart';

@freezed
class PavlokSettings with _$PavlokSettings {
  const factory PavlokSettings({
    required String apiToken,
    @Default(true) bool isEnabled,
    String? userEmail,
    DateTime? lastTestedAt,
    @Default(false) bool lastTestSuccess,
    String? lastErrorMessage,
  }) = _PavlokSettings;

  factory PavlokSettings.fromJson(Map<String, Object?> json) =>
      _$PavlokSettingsFromJson(json);
}
