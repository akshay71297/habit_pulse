import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_pulse/src/database/database_helper.dart';
import 'package:habit_pulse/src/database/habit_dao.dart';
import 'package:habit_pulse/src/database/scheduled_stimulus_dao.dart';
import 'package:habit_pulse/src/database/settings_dao.dart';
import 'package:habit_pulse/src/database/stimulus_log_dao.dart';

final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper.instance;
});

final habitDaoProvider = Provider<HabitDao>((ref) {
  return HabitDao(ref.watch(databaseHelperProvider));
});

final scheduledStimulusDaoProvider = Provider<ScheduledStimulusDao>((ref) {
  return ScheduledStimulusDao(ref.watch(databaseHelperProvider));
});

final stimulusLogDaoProvider = Provider<StimulusLogDao>((ref) {
  return StimulusLogDao(ref.watch(databaseHelperProvider));
});

final settingsDaoProvider = Provider<SettingsDao>((ref) {
  return SettingsDao(ref.watch(databaseHelperProvider));
});
