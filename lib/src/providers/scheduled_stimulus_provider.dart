import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_pulse/src/database/scheduled_stimulus_dao.dart';
import 'package:habit_pulse/src/models/scheduled_stimulus.dart';
import 'package:habit_pulse/src/providers/database_providers.dart';

class ScheduledStimulusListNotifier extends StateNotifier<AsyncValue<List<ScheduledStimulus>>> {
  final ScheduledStimulusDao _dao;

  ScheduledStimulusListNotifier(this._dao) : super(const AsyncValue.loading()) {
    _load();
  }

  Future<void> _load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _dao.getAll());
  }

  Future<void> refresh() => _load();

  List<ScheduledStimulus> get active => state.valueOrNull
          ?.where((s) => s.isActive)
          .toList() ??
      [];

  Future<void> add(ScheduledStimulus stimulus) async {
    await AsyncValue.guard(() => _dao.insert(stimulus));
    await _load();
  }

  Future<void> updateItem(ScheduledStimulus stimulus) async {
    await AsyncValue.guard(() => _dao.update(stimulus));
    await _load();
  }

  Future<void> delete(String id) async {
    await AsyncValue.guard(() => _dao.delete(id));
    await _load();
  }

  Future<void> toggleActive(String id, bool isActive) async {
    await AsyncValue.guard(() => _dao.toggleActive(id, isActive));
    await _load();
  }

  Future<void> markExecuted(String id, {DateTime? nextTime}) async {
    await AsyncValue.guard(() => _dao.markExecuted(id, nextTime: nextTime));
    await _load();
  }
}

final scheduledStimulusListProvider = StateNotifierProvider<ScheduledStimulusListNotifier, AsyncValue<List<ScheduledStimulus>>>((ref) {
  return ScheduledStimulusListNotifier(ref.watch(scheduledStimulusDaoProvider));
});

final scheduledStimulusByIdProvider = FutureProvider.family<ScheduledStimulus?, String>((ref, id) async {
  final dao = ref.watch(scheduledStimulusDaoProvider);
  return dao.getById(id);
});
