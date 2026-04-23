import 'package:sqflite/sqflite.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/database/database_helper.dart';
import 'package:habit_pulse/src/models/habit.dart';
import 'package:habit_pulse/src/core/services/logger_service.dart';

class HabitDao {
  final DatabaseHelper _helper;
  HabitDao(this._helper);

  Future<Database> get _db async => _helper.database;

  Future<List<Habit>> getAll() async {
    final db = await _db;
    final rows = await db.query('habits', orderBy: 'created_at DESC');
    return rows.map((r) => _fromMap(r)).toList();
  }

  Future<List<Habit>> getByType(String type) async {
    final db = await _db;
    final rows = await db.query(
      'habits',
      where: 'type = ?',
      whereArgs: [type],
      orderBy: 'created_at DESC',
    );
    return rows.map((r) => _fromMap(r)).toList();
  }

  Future<Habit?> getById(String id) async {
    final db = await _db;
    final rows = await db.query('habits', where: 'id = ?', whereArgs: [id]);
    if (rows.isEmpty) return null;
    return _fromMap(rows.first);
  }

  Future<void> insert(Habit habit) async {
    final db = await _db;
    await db.insert('habits', _toMap(habit), conflictAlgorithm: ConflictAlgorithm.replace);
    LoggerService.info('HabitDao: inserted habit ${habit.id}');
  }

  Future<void> update(Habit habit) async {
    final db = await _db;
    final map = _toMap(habit);
    map['updated_at'] = DateTime.now().toUtc().toIso8601String();
    await db.update('habits', map, where: 'id = ?', whereArgs: [habit.id]);
    LoggerService.info('HabitDao: updated habit ${habit.id}');
  }

  Future<void> delete(String id) async {
    final db = await _db;
    await db.delete('habits', where: 'id = ?', whereArgs: [id]);
    LoggerService.info('HabitDao: deleted habit $id');
  }

  Future<void> completeHabit(String id) async {
    final habit = await getById(id);
    if (habit == null) return;
    if (!habit.canIncrementStreak) return;

    final newStreak = habit.currentStreak + 1;
    final bestStreak = newStreak > habit.bestStreak ? newStreak : habit.bestStreak;

    final db = await _db;
    await db.update('habits', {
      'current_streak': newStreak,
      'best_streak': bestStreak,
      'total_completions': habit.totalCompletions + 1,
      'last_completed_at': DateTime.now().toUtc().toIso8601String(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }, where: 'id = ?', whereArgs: [id]);

    LoggerService.info('HabitDao: completed habit $id, streak $newStreak');
  }

  Map<String, dynamic> _toMap(Habit h) => {
    'id': h.id,
    'name': h.name,
    'description': h.description,
    'type': h.type.name,
    'is_active': h.isActive ? 1 : 0,
    'pavlok_stimulus_type': h.pavlokStimulusType,
    'stimulus_value': h.stimulusValue,
    'current_streak': h.currentStreak,
    'best_streak': h.bestStreak,
    'total_completions': h.totalCompletions,
    'last_completed_at': h.lastCompletedAt?.toUtc().toIso8601String(),
    'created_at': h.createdAt?.toUtc().toIso8601String(),
    'updated_at': h.updatedAt?.toUtc().toIso8601String(),
  };

  Habit _fromMap(Map<String, dynamic> m) => Habit(
    id: m['id'] as String,
    name: m['name'] as String,
    description: m['description'] as String,
    type: HabitType.values.byName(m['type'] as String),
    isActive: (m['is_active'] as int) == 1,
    pavlokStimulusType: m['pavlok_stimulus_type'] as String?,
    stimulusValue: m['stimulus_value'] as int,
    currentStreak: m['current_streak'] as int,
    bestStreak: m['best_streak'] as int,
    totalCompletions: m['total_completions'] as int,
    lastCompletedAt: m['last_completed_at'] != null ? DateTime.parse(m['last_completed_at'] as String) : null,
    createdAt: m['created_at'] != null ? DateTime.parse(m['created_at'] as String) : null,
    updatedAt: m['updated_at'] != null ? DateTime.parse(m['updated_at'] as String) : null,
  );
}
