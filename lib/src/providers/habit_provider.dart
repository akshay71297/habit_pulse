import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/database/habit_dao.dart';
import 'package:habit_pulse/src/models/habit.dart';
import 'package:habit_pulse/src/providers/database_providers.dart';

class HabitListNotifier extends StateNotifier<AsyncValue<List<Habit>>> {
  final HabitDao _dao;

  HabitListNotifier(this._dao) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _dao.getAll());
  }

  Future<void> refresh() => _load();

  List<Habit> get goodHabits => state.valueOrNull
          ?.where((h) => h.type == HabitType.good)
          .toList() ??
      [];

  List<Habit> get badHabits => state.valueOrNull
          ?.where((h) => h.type == HabitType.bad)
          .toList() ??
      [];

  Future<void> addHabit(Habit habit) async {
    await AsyncValue.guard(() => _dao.insert(habit));
    await _load();
  }

  Future<void> updateHabit(Habit habit) async {
    await AsyncValue.guard(() => _dao.update(habit));
    await _load();
  }

  Future<void> deleteHabit(String id) async {
    await AsyncValue.guard(() => _dao.delete(id));
    await _load();
  }

  Future<void> completeHabit(String id) async {
    await AsyncValue.guard(() => _dao.completeHabit(id));
    await _load();
  }
}

final habitListProvider = StateNotifierProvider<HabitListNotifier, AsyncValue<List<Habit>>>((ref) {
  return HabitListNotifier(ref.watch(habitDaoProvider));
});

final habitByIdProvider = FutureProvider.family<Habit?, String>((ref, id) async {
  final dao = ref.watch(habitDaoProvider);
  return dao.getById(id);
});
