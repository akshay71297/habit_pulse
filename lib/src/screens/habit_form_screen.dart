import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/core/utils/extensions.dart';
import 'package:habit_pulse/src/models/habit.dart';
import 'package:habit_pulse/src/providers/habit_provider.dart';

class HabitFormScreen extends ConsumerStatefulWidget {
  final String? habitId;
  const HabitFormScreen({this.habitId, super.key});

  @override
  ConsumerState<HabitFormScreen> createState() => _HabitFormScreenState();
}

class _HabitFormScreenState extends ConsumerState<HabitFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  HabitType _type = HabitType.good;
  StimulusType? _stimulusType;
  double _stimulusValue = AppConstants.defaultStimulusValue.toDouble();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.habitId != null) _loadHabit();
  }

  void _loadHabit() async {
    final habit = await ref.read(habitByIdProvider(widget.habitId!).future);
    if (habit != null && mounted) {
      setState(() {
        _nameCtrl.text = habit.name;
        _descCtrl.text = habit.description;
        _type = habit.type;
        _stimulusType = habit.pavlokStimulusType != null ? StimulusType.values.byName(habit.pavlokStimulusType!) : null;
        _stimulusValue = habit.stimulusValue.toDouble().clamp(
              AppConstants.minStimulusValue.toDouble(),
              AppConstants.maxStimulusValue.toDouble(),
            );
      });
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Color get _stimulusColor => switch (_stimulusType) {
        StimulusType.zap => const Color(0xFFFF3B30),
        StimulusType.vibrate => const Color(0xFF007AFF),
        StimulusType.beep => const Color(0xFFAF52DE),
        null => const Color(0xFF007AFF),
      };

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.habitId != null;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D20).withOpacity(0.95),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text(isEditing ? 'Edit Habit' : 'New Habit', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        leading: TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel', style: TextStyle(fontSize: 16, color: Color(0xFF4DA6FF))),
        ),
        leadingWidth: 80,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _save,
            child: _isLoading
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF4DA6FF))),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _DarkGlassSection(
              children: [
                _DarkTextField(
                  controller: _nameCtrl,
                  placeholder: 'Habit Name',
                  textCapitalization: TextCapitalization.sentences,
                  validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                Divider(height: 1, indent: 16, color: Colors.white.withOpacity(0.1)),
                _DarkTextField(
                  controller: _descCtrl,
                  placeholder: 'Description (optional)',
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _DarkGlassSection(
              title: 'HABIT TYPE',
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SegmentedButton<HabitType>(
                    style: SegmentedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.08),
                      selectedBackgroundColor: Colors.white.withOpacity(0.22),
                      selectedForegroundColor: Colors.white,
                      foregroundColor: Colors.white54,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(color: Colors.white.withOpacity(0.12)),
                    ),
                    segments: const [
                      ButtonSegment(value: HabitType.good, label: Text('Good')),
                      ButtonSegment(value: HabitType.bad, label: Text('Bad')),
                    ],
                    selected: {_type},
                    onSelectionChanged: (set) => setState(() => _type = set.first),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _DarkGlassSection(
              title: 'PAVLOK FEEDBACK',
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SegmentedButton<StimulusType?>(
                    style: SegmentedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.08),
                      selectedBackgroundColor: Colors.white.withOpacity(0.22),
                      selectedForegroundColor: Colors.white,
                      foregroundColor: Colors.white54,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(color: Colors.white.withOpacity(0.12)),
                    ),
                    segments: const [
                      ButtonSegment(value: null, label: Text('None')),
                      ButtonSegment(value: StimulusType.vibrate, label: Text('Vibe')),
                      ButtonSegment(value: StimulusType.zap, label: Text('Zap')),
                      ButtonSegment(value: StimulusType.beep, label: Text('Beep')),
                    ],
                    selected: {_stimulusType},
                    onSelectionChanged: (set) => setState(() => _stimulusType = set.first),
                  ),
                ),
                if (_stimulusType != null) ...[
                  Divider(height: 1, indent: 16, color: Colors.white.withOpacity(0.1)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Intensity', style: TextStyle(fontSize: 15, color: Colors.white60)),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _stimulusColor.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${_stimulusValue.toInt()} / ${AppConstants.maxStimulusValue}',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _stimulusColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SliderTheme(
                          data: const SliderThemeData(
                            trackHeight: 6,
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                          ),
                          child: Slider(
                            value: _stimulusValue,
                            min: AppConstants.minStimulusValue.toDouble(),
                            max: AppConstants.maxStimulusValue.toDouble(),
                            divisions: AppConstants.maxStimulusValue - AppConstants.minStimulusValue,
                            activeColor: _stimulusColor,
                            inactiveColor: Colors.white.withOpacity(0.18),
                            onChanged: (v) {
                              HapticFeedback.selectionClick();
                              setState(() => _stimulusValue = v);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final habit = widget.habitId != null
        ? (await ref.read(habitByIdProvider(widget.habitId!).future))?.copyWith(
            name: _nameCtrl.text.trim(),
            description: _descCtrl.text.trim(),
            type: _type,
            pavlokStimulusType: _stimulusType?.name,
            stimulusValue: _stimulusValue.toInt(),
          )
        : Habit.create(
            name: _nameCtrl.text.trim(),
            description: _descCtrl.text.trim(),
            type: _type,
            pavlokStimulusType: _stimulusType?.name,
            stimulusValue: _stimulusValue.toInt(),
          );

    if (habit == null) {
      setState(() => _isLoading = false);
      return;
    }

    if (widget.habitId != null) {
      await ref.read(habitListProvider.notifier).updateHabit(habit);
    } else {
      await ref.read(habitListProvider.notifier).addHabit(habit);
    }

    if (mounted) {
      context.pop();
      context.showSnackBar(widget.habitId != null ? 'Habit updated' : 'Habit created');
    }
  }
}

class _DarkGlassSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const _DarkGlassSection({this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white54, letterSpacing: 0.6),
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Column(children: children)),
            ),
          ),
        ),
      ],
    );
  }
}

class _DarkTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;

  const _DarkTextField({
    required this.controller,
    required this.placeholder,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      textCapitalization: textCapitalization,
      validator: validator,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: InputBorder.none,
        errorStyle: const TextStyle(color: Color(0xFFFF3B30)),
      ),
    );
  }
}
