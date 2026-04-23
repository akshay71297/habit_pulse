import 'package:sqflite/sqflite.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/database/database_helper.dart';
import 'package:habit_pulse/src/models/scheduled_stimulus.dart';
import 'package:habit_pulse/src/core/services/logger_service.dart';

class ScheduledStimulusDao {
  final DatabaseHelper _helper;
  ScheduledStimulusDao(this._helper);

  Future<Database> get _db async => _helper.database;

  Future<List<ScheduledStimulus>> getAll() async {
    final db = await _db;
    final rows = await db.query('scheduled_stimuli', orderBy: 'scheduled_time ASC');
    return rows.map((r) => _fromMap(r)).toList();
  }

  Future<List<ScheduledStimulus>> getActive() async {
    final db = await _db;
    final rows = await db.query(
      'scheduled_stimuli',
      where: 'is_active = ?',
      whereArgs: [1],
      orderBy: 'scheduled_time ASC',
    );
    return rows.map((r) => _fromMap(r)).toList();
  }

  Future<List<ScheduledStimulus>> getPendingBefore(DateTime time) async {
    final db = await _db;
    final rows = await db.query(
      'scheduled_stimuli',
      where: 'is_active = ? AND executed = ? AND scheduled_time <= ?',
      whereArgs: [1, 0, time.toUtc().toIso8601String()],
      orderBy: 'scheduled_time ASC',
    );
    return rows.map((r) => _fromMap(r)).toList();
  }

  Future<ScheduledStimulus?> getById(String id) async {
    final db = await _db;
    final rows = await db.query('scheduled_stimuli', where: 'id = ?', whereArgs: [id]);
    if (rows.isEmpty) return null;
    return _fromMap(rows.first);
  }

  Future<void> insert(ScheduledStimulus stimulus) async {
    final db = await _db;
    await db.insert('scheduled_stimuli', _toMap(stimulus), conflictAlgorithm: ConflictAlgorithm.replace);
    LoggerService.info('ScheduledStimulusDao: inserted ${stimulus.id}');
  }

  Future<void> update(ScheduledStimulus stimulus) async {
    final db = await _db;
    await db.update('scheduled_stimuli', _toMap(stimulus), where: 'id = ?', whereArgs: [stimulus.id]);
    LoggerService.info('ScheduledStimulusDao: updated ${stimulus.id}');
  }

  Future<void> delete(String id) async {
    final db = await _db;
    await db.delete('scheduled_stimuli', where: 'id = ?', whereArgs: [id]);
    LoggerService.info('ScheduledStimulusDao: deleted $id');
  }

  Future<void> markExecuted(String id, {DateTime? nextTime}) async {
    final db = await _db;
    if (nextTime != null) {
      await db.update('scheduled_stimuli', {
        'scheduled_time': nextTime.toUtc().toIso8601String(),
        'executed': 0,
        'last_executed_at': DateTime.now().toUtc().toIso8601String(),
      }, where: 'id = ?', whereArgs: [id]);
    } else {
      await db.update('scheduled_stimuli', {
        'executed': 1,
        'last_executed_at': DateTime.now().toUtc().toIso8601String(),
      }, where: 'id = ?', whereArgs: [id]);
    }
    LoggerService.info('ScheduledStimulusDao: marked executed $id');
  }

  Future<void> toggleActive(String id, bool isActive) async {
    final db = await _db;
    await db.update('scheduled_stimuli', {'is_active': isActive ? 1 : 0}, where: 'id = ?', whereArgs: [id]);
  }

  Map<String, dynamic> _toMap(ScheduledStimulus s) => {
    'id': s.id,
    'name': s.name,
    'stimulus_type': s.stimulusType.name,
    'stimulus_value': s.stimulusValue,
    'scheduled_time': s.scheduledTime.toUtc().toIso8601String(),
    'is_recurring': s.isRecurring ? 1 : 0,
    'repeat_unit': s.repeatUnit?.name,
    'repeat_interval': s.repeatInterval,
    'end_date': s.endDate?.toUtc().toIso8601String(),
    'is_active': s.isActive ? 1 : 0,
    'associated_habit_id': s.associatedHabitId,
    'executed': s.executed ? 1 : 0,
    'last_executed_at': s.lastExecutedAt?.toUtc().toIso8601String(),
    'created_at': s.createdAt?.toUtc().toIso8601String(),
  };

  ScheduledStimulus _fromMap(Map<String, dynamic> m) => ScheduledStimulus(
    id: m['id'] as String,
    name: m['name'] as String,
    stimulusType: StimulusType.values.byName(m['stimulus_type'] as String),
    stimulusValue: m['stimulus_value'] as int,
    scheduledTime: DateTime.parse(m['scheduled_time'] as String),
    isRecurring: (m['is_recurring'] as int) == 1,
    repeatUnit: m['repeat_unit'] != null ? ScheduleRepeatUnit.values.byName(m['repeat_unit'] as String) : null,
    repeatInterval: m['repeat_interval'] as int,
    endDate: m['end_date'] != null ? DateTime.parse(m['end_date'] as String) : null,
    isActive: (m['is_active'] as int) == 1,
    associatedHabitId: m['associated_habit_id'] as String?,
    executed: (m['executed'] as int) == 1,
    lastExecutedAt: m['last_executed_at'] != null ? DateTime.parse(m['last_executed_at'] as String) : null,
    createdAt: m['created_at'] != null ? DateTime.parse(m['created_at'] as String) : null,
  );
}
