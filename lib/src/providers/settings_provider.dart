import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_pulse/src/database/settings_dao.dart';
import 'package:habit_pulse/src/models/pavlok_settings.dart';
import 'package:habit_pulse/src/providers/database_providers.dart';
import 'package:habit_pulse/src/services/pavlok_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final pavlokSettingsProvider = FutureProvider<PavlokSettings?>((ref) async {
  final dao = ref.watch(settingsDaoProvider);
  final settings = await dao.getSettings();
  if (settings != null && settings.apiToken.isNotEmpty) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pavlok_api_token', settings.apiToken);
  }
  return settings;
});

final pavlokApiServiceProvider = Provider<PavlokApiService>((ref) {
  final service = PavlokApiService();
  ref.listen(pavlokSettingsProvider, (_, next) {
    next.whenData((settings) {
      if (settings != null) service.updateSettings(settings);
    });
  });
  return service;
});

class SettingsNotifier extends StateNotifier<AsyncValue<void>> {
  final SettingsDao _dao;
  final PavlokApiService _apiService;

  SettingsNotifier(this._dao, this._apiService) : super(const AsyncValue.data(null));

  Future<void> saveSettings(PavlokSettings settings) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _dao.saveSettings(settings);
      _apiService.updateSettings(settings);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('pavlok_api_token', settings.apiToken);
    });
  }

  Future<bool> testConnection() async {
    state = const AsyncValue.loading();
    final result = await _apiService.testConnection();
    final now = DateTime.now().toUtc();

    final current = await _dao.getSettings();
    if (current == null) return false;

    switch (result) {
      case PavlokSuccess():
        await _dao.saveSettings(current.copyWith(
          lastTestedAt: now,
          lastTestSuccess: true,
          lastErrorMessage: null,
        ));
        state = const AsyncValue.data(null);
        return true;
      case PavlokError(:final message):
        await _dao.saveSettings(current.copyWith(
          lastTestedAt: now,
          lastTestSuccess: false,
          lastErrorMessage: message,
        ));
        state = AsyncValue.error(message, StackTrace.current);
        return false;
    }
  }

  Future<void> clearToken() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _dao.clearToken();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('pavlok_api_token');
    });
  }
}

final settingsNotifierProvider = StateNotifierProvider<SettingsNotifier, AsyncValue<void>>((ref) {
  return SettingsNotifier(
    ref.watch(settingsDaoProvider),
    ref.watch(pavlokApiServiceProvider),
  );
});
