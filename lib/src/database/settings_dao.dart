import 'package:sqflite/sqflite.dart';
import 'package:habit_pulse/src/database/database_helper.dart';
import 'package:habit_pulse/src/models/pavlok_settings.dart';
import 'package:habit_pulse/src/core/services/logger_service.dart';

class SettingsDao {
  final DatabaseHelper _helper;
  SettingsDao(this._helper);

  Future<Database> get _db async => _helper.database;

  Future<PavlokSettings?> getSettings() async {
    final db = await _db;
    final rows = await db.query('pavlok_settings', where: 'id = 1');
    if (rows.isEmpty) return null;
    return _fromMap(rows.first);
  }

  Future<void> saveSettings(PavlokSettings settings) async {
    final db = await _db;
    await db.insert(
      'pavlok_settings',
      _toMap(settings),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    LoggerService.info('SettingsDao: saved settings');
  }

  Future<void> clearToken() async {
    final db = await _db;
    await db.update('pavlok_settings', {'api_token': null}, where: 'id = 1');
    LoggerService.info('SettingsDao: cleared token');
  }

  Map<String, dynamic> _toMap(PavlokSettings s) => {
    'id': 1,
    'api_token': s.apiToken,
    'is_enabled': s.isEnabled ? 1 : 0,
    'user_email': s.userEmail,
    'last_tested_at': s.lastTestedAt?.toUtc().toIso8601String(),
    'last_test_success': s.lastTestSuccess ? 1 : 0,
    'last_error_message': s.lastErrorMessage,
  };

  PavlokSettings _fromMap(Map<String, dynamic> m) => PavlokSettings(
    apiToken: m['api_token'] as String? ?? '',
    isEnabled: (m['is_enabled'] as int? ?? 1) == 1,
    userEmail: m['user_email'] as String?,
    lastTestedAt: m['last_tested_at'] != null ? DateTime.parse(m['last_tested_at'] as String) : null,
    lastTestSuccess: (m['last_test_success'] as int? ?? 0) == 1,
    lastErrorMessage: m['last_error_message'] as String?,
  );
}
