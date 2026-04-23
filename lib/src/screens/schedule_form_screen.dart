import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/core/utils/extensions.dart';
import 'package:habit_pulse/src/models/scheduled_stimulus.dart';
import 'package:habit_pulse/src/providers/scheduled_stimulus_provider.dart';

class ScheduleFormScreen extends ConsumerStatefulWidget {
  const ScheduleFormScreen({super.key});

  @override
  ConsumerState<ScheduleFormScreen> createState() => _ScheduleFormScreenState();
}

class _ScheduleFormScreenState extends ConsumerState<ScheduleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  StimulusType _stimulusType = StimulusType.vibe;
  double _intensity = 50;
  DateTime _scheduledTime = DateTime.now().add(const Duration(minutes: 5));
  bool _isRecurring = false;
  ScheduleRepeatUnit _repeatUnit = ScheduleRepeatUnit.hours;
  int _repeatInterval = 1;
  DateTime? _endDate;
  bool _isLoading = false;

  Color get _stimulusColor => switch (_stimulusType) {
        StimulusType.zap => const Color(0xFFFF3B30),
        StimulusType.vibe => const Color(0xFF007AFF),
        StimulusType.beep => const Color(0xFFAF52DE),
      };

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D20).withOpacity(0.95),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('New Schedule', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
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
                  placeholder: 'Schedule Name',
                  textCapitalization: TextCapitalization.sentences,
                  validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _DarkGlassSection(
              title: 'STIMULUS TYPE',
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SegmentedButton<StimulusType>(
                    style: SegmentedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.08),
                      selectedBackgroundColor: Colors.white.withOpacity(0.22),
                      selectedForegroundColor: Colors.white,
                      foregroundColor: Colors.white54,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(color: Colors.white.withOpacity(0.12)),
                    ),
                    segments: const [
                      ButtonSegment(value: StimulusType.vibe, label: Text('Vibe')),
                      ButtonSegment(value: StimulusType.zap, label: Text('Zap')),
                      ButtonSegment(value: StimulusType.beep, label: Text('Beep')),
                    ],
                    selected: {_stimulusType},
                    onSelectionChanged: (set) => setState(() => _stimulusType = set.first),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _DarkGlassSection(
              title: 'INTENSITY',
              children: [
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
                              '${_intensity.toInt()} / 255',
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
                          value: _intensity,
                          min: 1,
                          max: 255,
                          divisions: 254,
                          activeColor: _stimulusColor,
                          inactiveColor: Colors.white.withOpacity(0.18),
                          onChanged: (v) {
                            HapticFeedback.selectionClick();
                            setState(() => _intensity = v);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _DarkGlassSection(
              title: 'FIRST RUN',
              children: [
                _DarkRow(
                  icon: Icons.calendar_today_rounded,
                  label: 'Date & Time',
                  value: _scheduledTime.toLocal().toFormattedString(),
                  onTap: _pickDateTime,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _DarkGlassSection(
              title: 'REPEAT',
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: Row(
                    children: [
                      const Text('Recurring schedule', style: TextStyle(fontSize: 16, color: Colors.white)),
                      const Spacer(),
                      Switch.adaptive(
                        value: _isRecurring,
                        activeColor: const Color(0xFF34C759),
                        inactiveTrackColor: Colors.white.withOpacity(0.15),
                        onChanged: (v) => setState(() => _isRecurring = v),
                      ),
                    ],
                  ),
                ),
                if (_isRecurring) ...[
                  Divider(height: 1, indent: 16, color: Colors.white.withOpacity(0.1)),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<ScheduleRepeatUnit>(
                            value: _repeatUnit,
                            dropdownColor: const Color(0xFF1C1C2E),
                            decoration: InputDecoration(
                              labelText: 'Unit',
                              labelStyle: const TextStyle(color: Colors.white54),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.08),
                            ),
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            items: ScheduleRepeatUnit.values.map((u) {
                              return DropdownMenuItem(
                                value: u,
                                child: Text(u.name, style: const TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                            onChanged: (v) => setState(() => _repeatUnit = v!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            initialValue: '$_repeatInterval',
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                              labelText: 'Every',
                              labelStyle: const TextStyle(color: Colors.white54),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.08),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (v) => setState(() => _repeatInterval = int.tryParse(v) ?? 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, indent: 16, color: Colors.white.withOpacity(0.1)),
                  _DarkRow(
                    icon: Icons.event_busy_rounded,
                    label: 'End Date',
                    value: _endDate == null ? 'Never' : _endDate!.toLocal().toDateString(),
                    onTap: _pickEndDate,
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

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_scheduledTime),
    );
    if (time == null || !mounted) return;
    setState(() => _scheduledTime = DateTime(date.year, date.month, date.day, time.hour, time.minute));
  }

  Future<void> _pickEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _scheduledTime.add(const Duration(days: 30)),
      firstDate: _scheduledTime,
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (date != null && mounted) setState(() => _endDate = date);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_scheduledTime.isBefore(DateTime.now())) {
      context.showSnackBar('Scheduled time must be in the future', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final schedule = ScheduledStimulus.create(
      name: _nameCtrl.text.trim(),
      stimulusType: _stimulusType,
      stimulusValue: _intensity.toInt(),
      scheduledTime: _scheduledTime,
      isRecurring: _isRecurring,
      repeatUnit: _isRecurring ? _repeatUnit : null,
      repeatInterval: _isRecurring ? _repeatInterval : 1,
      endDate: _endDate,
    );

    await ref.read(scheduledStimulusListProvider.notifier).add(schedule);

    if (mounted) {
      context.pop();
      context.showSnackBar('Schedule created');
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

class _DarkRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DarkRow({required this.icon, required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.white38),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16, color: Colors.white)),
            const Spacer(),
            Text(value, style: const TextStyle(fontSize: 16, color: Colors.white54)),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, size: 18, color: Colors.white38),
          ],
        ),
      ),
    );
  }
}
