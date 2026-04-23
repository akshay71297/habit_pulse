import 'package:sqflite/sqflite.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/database/database_helper.dart';
import 'package:habit_pulse/src/models/stimulus_log.dart';
import 'package:habit_pulse/src/core/services/logger_service.dart';

class StimulusLogDao {
  final DatabaseHelper _helper;
  StimulusLogDao(this._helper);

  Future<Database> get _db async => _helper.database;

  Future<List<StimulusLog>> getAll({int limit = 100}) async {
    final db = await _db;
    final rows = await db.query(
      'stimulus_logs',
      orderBy: 'executed_at DESC',
      limit: limit,
    );
    return rows.map((r) => _fromMap(r)).toList();
  }

  Future<List<StimulusLog>> getByHabitId(String habitId, {int limit = 50}) async {
    final db = await _db;
    final rows = await db.query(
      'stimulus_logs',
      where: 'habit_id = ?',
      whereArgs: [habitId],
      orderBy: 'executed_at DESC',
      limit: limit,
    );
    return rows.map((r) => _fromMap(r)).toList();
  }

  Future<void> insert(StimulusLog log) async {
    final db = await _db;
    await db.insert('stimulus_logs', _toMap(log), conflictAlgorithm: ConflictAlgorithm.replace);
    LoggerService.info('StimulusLogDao: inserted log ${log.id}');
  }

  Future<void> deleteOldLogs(Duration maxAge) async {
    final db = await _db;
    final cutoff = DateTime.now().toUtc().subtract(maxAge).toIso8601String();
    final count = await db.delete('stimulus_logs', where: 'executed_at < ?', whereArgs: [cutoff]);
    LoggerService.info('StimulusLogDao: deleted $count old logs');
  }

  Map<String, dynamic> _toMap(StimulusLog l) => {
    'id': l.id,
    'stimulus_type': l.stimulusType.name,
    'stimulus_value': l.stimulusValue,
    'executed_at': l.executedAt.toUtc().toIso8601String(),
    'success': l.success ? 1 : 0,
    'error_message': l.errorMessage,
    'habit_id': l.habitId,
    'schedule_id': l.scheduleId,
    'from_offline_queue': l.fromOfflineQueue ? 1 : 0,
  };

  StimulusLog _fromMap(Map<String, dynamic> m) => StimulusLog(
    id: m['id'] as String,
    stimulusType: StimulusType.values.byName(m['stimulus_type'] as String),
    stimulusValue: m['stimulus_value'] as int,
    executedAt: DateTime.parse(m['executed_at'] as String),
    success: (m['success'] as int) == 1,
    errorMessage: m['error_message'] as String?,
    habitId: m['habit_id'] as String?,
    scheduleId: m['schedule_id'] as String?,
    fromOfflineQueue: (m['from_offline_queue'] as int) == 1,
  );
}
