import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/core/utils/extensions.dart';
import 'package:habit_pulse/src/models/habit.dart';
import 'package:habit_pulse/src/providers/habit_provider.dart';
import 'package:habit_pulse/src/providers/stimulus_provider.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitListProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                child: Row(
                  children: [
                    const Text(
                      'Habits',
                      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -0.5),
                    ),
                    const Spacer(),
                    FloatingActionButton.small(
                      elevation: 0,
                      backgroundColor: context.colors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      onPressed: () => context.push('/habits/add'),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white38,
                indicatorColor: Colors.white,
                dividerColor: Colors.transparent,
                labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                tabs: [
                  Tab(text: 'Good'),
                  Tab(text: 'Bad'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _HabitList(
                      habitsAsync: habitsAsync,
                      type: HabitType.good,
                      emptyTitle: 'No good habits yet',
                      emptySubtitle: 'Build something positive. Tap + to start.',
                    ),
                    _HabitList(
                      habitsAsync: habitsAsync,
                      type: HabitType.bad,
                      emptyTitle: 'No bad habits tracked',
                      emptySubtitle: 'Break the cycle. Add one now.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HabitList extends ConsumerWidget {
  final AsyncValue<List<Habit>> habitsAsync;
  final HabitType type;
  final String emptyTitle;
  final String emptySubtitle;

  const _HabitList({
    required this.habitsAsync,
    required this.type,
    required this.emptyTitle,
    required this.emptySubtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return habitsAsync.when(
      data: (allHabits) {
        final habits = allHabits.where((h) => h.type == type).toList();
        if (habits.isEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: _EmptyState(title: emptyTitle, subtitle: emptySubtitle),
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 40,
                  child: FadeInAnimation(child: _HabitCard(habit: habit)),
                ),
              );
            },
          ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
    );
  }
}

class _HabitCard extends ConsumerWidget {
  final Habit habit;
  const _HabitCard({required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGood = habit.type == HabitType.good;
    final accentColor = isGood ? const Color(0xFF34C759) : const Color(0xFFFF3B30);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.22,
          children: [
            CustomSlidableAction(
              onPressed: (_) => _confirmDelete(context, ref),
              backgroundColor: const Color(0xFFFF3B30),
              borderRadius: BorderRadius.circular(18),
              child: const Icon(Icons.delete_rounded, color: Colors.white),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withOpacity(0.14), width: 1),
                boxShadow: [
                  BoxShadow(color: accentColor.withOpacity(0.12), blurRadius: 24, offset: const Offset(0, 8)),
                  BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4)),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => context.push('/habits/edit/${habit.id}'),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isGood ? 'GOOD' : 'BAD',
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (habit.canIncrementStreak)
                            _IosButton(
                              onTap: () async {
                                HapticFeedback.mediumImpact();
                                await ref.read(habitListProvider.notifier).completeHabit(habit.id);
                                if (habit.pavlokStimulusType != null && context.mounted) {
                                  final type = StimulusType.values.byName(habit.pavlokStimulusType!);
                                  await ref.read(stimulusNotifierProvider.notifier).send(
                                        type: type,
                                        value: habit.stimulusValue,
                                        habitId: habit.id,
                                      );
                                  if (context.mounted) {
                                    context.showSnackBar('Done! ${type.name.toUpperCase()} sent.');
                                  }
                                } else if (context.mounted) {
                                  context.showSnackBar('Habit completed! Great job.');
                                }
                              },
                              label: 'Done',
                              color: const Color(0xFF007AFF),
                            )
                          else
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.local_fire_department_rounded, color: Color(0xFFFF9500), size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  '${habit.currentStreak}',
                                  style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFFF9500)),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        habit.name,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: -0.3, color: Colors.white),
                      ),
                      if (habit.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          habit.description,
                          style: const TextStyle(fontSize: 14, color: Colors.white60, height: 1.3),
                        ),
                      ],
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          _StatChip(icon: Icons.local_fire_department_rounded, label: habit.streakDisplay, color: const Color(0xFFFF9500)),
                          const SizedBox(width: 10),
                          _StatChip(icon: Icons.emoji_events_rounded, label: 'Best ${habit.bestStreak}', color: const Color(0xFFFFCC00)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Habit?'),
        content: Text('"${habit.name}" will be permanently removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF007AFF))),
          ),
          TextButton(
            onPressed: () {
              ref.read(habitListProvider.notifier).deleteHabit(habit.id);
              Navigator.pop(ctx);
              context.showSnackBar('Habit deleted');
            },
            child: const Text('Delete', style: TextStyle(color: Color(0xFFFF3B30))),
          ),
        ],
      ),
    );
  }
}

class _IosButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color color;
  const _IosButton({required this.onTap, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.18),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _StatChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  const _EmptyState({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline_rounded, size: 60, color: Colors.white24),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white60)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.white38)),
        ],
      ),
    );
  }
}
