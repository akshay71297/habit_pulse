import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';

part 'habit.freezed.dart';
part 'habit.g.dart';

@freezed
class Habit with _$Habit {
  const factory Habit({
    required String id,
    required String name,
    required String description,
    required HabitType type,
    @Default(false) bool isActive,
    String? pavlokStimulusType,
    @Default(50) int stimulusValue,
    @Default(0) int currentStreak,
    @Default(0) int bestStreak,
    @Default(0) int totalCompletions,
    DateTime? lastCompletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Habit;

  factory Habit.fromJson(Map<String, Object?> json) => _$HabitFromJson(json);

  const Habit._();

  factory Habit.create({
    required String name,
    required String description,
    required HabitType type,
    String? pavlokStimulusType,
    int stimulusValue = 50,
  }) {
    final now = DateTime.now().toUtc();
    return Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      type: type,
      pavlokStimulusType: pavlokStimulusType,
      stimulusValue: stimulusValue,
      createdAt: now,
      updatedAt: now,
    );
  }

  bool get canIncrementStreak {
    if (lastCompletedAt == null) return true;
    final last = lastCompletedAt!.toLocal();
    final now = DateTime.now();
    return last.year != now.year || last.month != now.month || last.day != now.day;
  }

  String get streakDisplay => '$currentStreak day${currentStreak == 1 ? '' : 's'}';
}
