import 'package:flutter/material.dart';
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
  StimulusType _stimulusType = StimulusType.vibrate;
  double _intensity = 50;
  DateTime _scheduledTime = DateTime.now().add(const Duration(minutes: 5));
  bool _isRecurring = false;
  ScheduleRepeatUnit _repeatUnit = ScheduleRepeatUnit.hours;
  int _repeatInterval = 1;
  DateTime? _endDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F7).withOpacity(0.9),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text('New Schedule', style: TextStyle(fontWeight: FontWeight.w600)),
        leading: TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel', style: TextStyle(fontSize: 16, color: Color(0xFF007AFF))),
        ),
        leadingWidth: 80,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _save,
            child: _isLoading
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF007AFF))),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _IosSection(
              children: [
                _IosTextField(
                  controller: _nameCtrl,
                  placeholder: 'Schedule Name',
                  validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _IosSection(
              title: 'Stimulus Type',
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SegmentedButton<StimulusType>(
                    style: SegmentedButton.styleFrom(
                      backgroundColor: const Color(0xFFE5E5EA),
                      selectedBackgroundColor: Colors.white,
                      selectedForegroundColor: Colors.black,
                      foregroundColor: Colors.grey.shade600,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    segments: const [
                      ButtonSegment(value: StimulusType.vibrate, label: Text('Vibrate')),
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
            _IosSection(
              title: 'Intensity',
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${_intensity.toInt()}', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w300)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Slider(
                        value: _intensity,
                        min: 1,
                        max: 255,
                        divisions: 254,
                        activeColor: const Color(0xFF007AFF),
                        inactiveColor: const Color(0xFFE5E5EA),
                        onChanged: (v) => setState(() => _intensity = v),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _IosSection(
              title: 'First Run',
              children: [
                _IosRow(
                  icon: Icons.calendar_today,
                  label: 'Date & Time',
                  value: _scheduledTime.toLocal().toFormattedString(),
                  onTap: _pickDateTime,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _IosSection(
              title: 'Repeat',
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: Row(
                    children: [
                      Text('Recurring schedule', style: TextStyle(fontSize: 16, color: Colors.grey.shade800)),
                      const Spacer(),
                      Switch.adaptive(
                        value: _isRecurring,
                        activeColor: const Color(0xFF34C759),
                        onChanged: (v) => setState(() => _isRecurring = v),
                      ),
                    ],
                  ),
                ),
                if (_isRecurring) ...[
                  const Divider(height: 1, indent: 16),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<ScheduleRepeatUnit>(
                            value: _repeatUnit,
                            decoration: InputDecoration(
                              labelText: 'Unit',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                              filled: true,
                              fillColor: const Color(0xFFF2F2F7),
                            ),
                            items: ScheduleRepeatUnit.values.map((u) {
                              return DropdownMenuItem(value: u, child: Text(u.name));
                            }).toList(),
                            onChanged: (v) => setState(() => _repeatUnit = v!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            initialValue: '$_repeatInterval',
                            decoration: InputDecoration(
                              labelText: 'Every',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                              filled: true,
                              fillColor: const Color(0xFFF2F2F7),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (v) => setState(() => _repeatInterval = int.tryParse(v) ?? 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, indent: 16),
                  _IosRow(
                    icon: Icons.event_busy,
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

class _IosSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _IosSection({this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(title!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade500)),
          ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Column(children: children)),
        ),
      ],
    );
  }
}

class _IosTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final String? Function(String?)? validator;

  const _IosTextField({required this.controller, required this.placeholder, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: InputBorder.none,
        errorStyle: const TextStyle(color: Color(0xFFFF3B30)),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}

class _IosRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _IosRow({required this.icon, required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey.shade500),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Text(value, style: TextStyle(fontSize: 16, color: Colors.grey.shade500)),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, size: 18, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
