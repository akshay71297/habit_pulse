import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/core/utils/extensions.dart';
import 'package:habit_pulse/src/models/scheduled_stimulus.dart';
import 'package:habit_pulse/src/providers/scheduled_stimulus_provider.dart';
import 'package:habit_pulse/src/providers/stimulus_provider.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsync = ref.watch(scheduledStimulusListProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                children: [
                  const Text(
                    'Schedule',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -0.5),
                  ),
                  const Spacer(),
                  FloatingActionButton.small(
                    elevation: 0,
                    backgroundColor: context.colors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    onPressed: () => context.push('/schedule/add'),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              child: schedulesAsync.when(
                data: (all) {
                  final schedules = all.where((s) => s.isActive).toList();
                  if (schedules.isEmpty) return const _EmptyState();
                  return AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                      itemCount: schedules.length,
                      itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 40,
                          child: FadeInAnimation(child: _ScheduleCard(schedule: schedules[index])),
                        ),
                      ),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleCard extends ConsumerWidget {
  final ScheduledStimulus schedule;

  const _ScheduleCard({required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = switch (schedule.stimulusType) {
      StimulusType.zap => const Color(0xFFFF3B30),
      StimulusType.vibe => const Color(0xFF007AFF),
      StimulusType.beep => const Color(0xFFAF52DE),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
                BoxShadow(color: color.withOpacity(0.12), blurRadius: 20, offset: const Offset(0, 6)),
                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
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
                          color: color.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          schedule.stimulusType.name.toUpperCase(),
                          style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                        ),
                      ),
                      const Spacer(),
                      _ActionIcon(
                        icon: Icons.play_arrow_rounded,
                        color: const Color(0xFF34C759),
                        onTap: () async {
                          await ref.read(stimulusNotifierProvider.notifier).send(
                                type: schedule.stimulusType,
                                value: schedule.stimulusValue,
                                scheduleId: schedule.id,
                              );
                          if (context.mounted) context.showSnackBar('Executed ${schedule.stimulusType.name} now');
                        },
                      ),
                      _ActionIcon(
                        icon: Icons.delete_outline_rounded,
                        color: const Color(0xFFFF3B30),
                        onTap: () => _confirmDelete(context, ref),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    schedule.name,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: -0.3, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.bolt_rounded, size: 15, color: Colors.white38),
                      const SizedBox(width: 5),
                      Text('Intensity ${schedule.stimulusValue}', style: const TextStyle(fontSize: 14, color: Colors.white54)),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time_rounded, size: 15, color: Colors.white38),
                      const SizedBox(width: 5),
                      Text(
                        schedule.scheduledTime.toLocal().toFormattedString(),
                        style: const TextStyle(fontSize: 14, color: Colors.white54),
                      ),
                    ],
                  ),
                  if (schedule.isRecurring) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.repeat_rounded, size: 15, color: Colors.white38),
                        const SizedBox(width: 5),
                        Text(
                          'Every ${schedule.repeatInterval} ${schedule.repeatUnit!.name}',
                          style: const TextStyle(fontSize: 14, color: Colors.white54),
                        ),
                      ],
                    ),
                  ],
                ],
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
        backgroundColor: const Color(0xFF1C1C2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Schedule?', style: TextStyle(color: Colors.white)),
        content: Text('"${schedule.name}" will be permanently removed.', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF4DA6FF))),
          ),
          TextButton(
            onPressed: () {
              ref.read(scheduledStimulusListProvider.notifier).delete(schedule.id);
              Navigator.pop(ctx);
              context.showSnackBar('Schedule deleted');
            },
            child: const Text('Delete', style: TextStyle(color: Color(0xFFFF3B30))),
          ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  const _ActionIcon({required this.icon, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: (color ?? Colors.white).withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (color ?? Colors.white).withOpacity(0.2), width: 0.5),
        ),
        child: Icon(icon, size: 20, color: color ?? Colors.white54),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule_rounded, size: 60, color: Colors.white24),
          SizedBox(height: 16),
          Text('Nothing scheduled', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white60)),
          SizedBox(height: 6),
          Text('Automate your Pavlok stimuli.', style: TextStyle(fontSize: 14, color: Colors.white38)),
        ],
      ),
    );
  }
}
