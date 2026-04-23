import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/providers/stimulus_provider.dart';

class StimulusScreen extends ConsumerStatefulWidget {
  const StimulusScreen({super.key});

  @override
  ConsumerState<StimulusScreen> createState() => _StimulusScreenState();
}

class _StimulusScreenState extends ConsumerState<StimulusScreen> {
  StimulusType _selectedType = StimulusType.zap;
  double _intensity = AppConstants.defaultStimulusValue.toDouble();

  Color get _accentColor => switch (_selectedType) {
        StimulusType.zap => const Color(0xFFFF3B30),
        StimulusType.vibe => const Color(0xFF007AFF),
        StimulusType.beep => const Color(0xFFAF52DE),
      };

  @override
  Widget build(BuildContext context) {
    final stimulusAsync = ref.watch(stimulusNotifierProvider);
    final isLoading = stimulusAsync.isLoading;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Text(
                'Stimulus',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -0.5),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                child: Column(
                  children: [
                _DarkGlassSection(
                  title: 'TYPE',
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        _TypeButton(
                          type: StimulusType.vibe,
                          icon: Icons.vibration_rounded,
                          label: 'Vibe',
                          color: const Color(0xFF007AFF),
                          selected: _selectedType,
                          onTap: (t) => setState(() => _selectedType = t),
                        ),
                        _TypeButton(
                          type: StimulusType.zap,
                          icon: Icons.bolt_rounded,
                          label: 'Zap',
                          color: const Color(0xFFFF3B30),
                          selected: _selectedType,
                          onTap: (t) => setState(() => _selectedType = t),
                        ),
                        _TypeButton(
                          type: StimulusType.beep,
                          icon: Icons.volume_up_rounded,
                          label: 'Beep',
                          color: const Color(0xFFAF52DE),
                          selected: _selectedType,
                          onTap: (t) => setState(() => _selectedType = t),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _DarkGlassSection(
                  title: 'INTENSITY',
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: _intensity, end: _intensity),
                                duration: const Duration(milliseconds: 120),
                                builder: (_, v, __) => CustomPaint(
                                  size: const Size(200, 200),
                                  painter: _ArcPainter(value: v, max: AppConstants.maxStimulusValue.toDouble(), color: _accentColor),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 120),
                                    style: TextStyle(
                                      fontSize: 64,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: -4,
                                      height: 1,
                                      color: _accentColor,
                                    ),
                                    child: Text('${_intensity.toInt()}'),
                                  ),
                                  Text(
                                    'of ${AppConstants.maxStimulusValue}',
                                    style: const TextStyle(fontSize: 13, color: Colors.white54, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          children: [
                            Text('0', style: TextStyle(fontSize: 12, color: Colors.white38, fontWeight: FontWeight.w600)),
                            Spacer(),
                            Text('100', style: TextStyle(fontSize: 12, color: Colors.white38, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        SliderTheme(
                          data: const SliderThemeData(
                            trackHeight: 6,
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 22),
                          ),
                          child: Slider(
                            value: _intensity,
                            min: AppConstants.minStimulusValue.toDouble(),
                            max: AppConstants.maxStimulusValue.toDouble(),
                            divisions: AppConstants.maxStimulusValue - AppConstants.minStimulusValue,
                            activeColor: _accentColor,
                            inactiveColor: Colors.white.withOpacity(0.18),
                            onChanged: isLoading
                                ? null
                                : (v) {
                                    HapticFeedback.selectionClick();
                                    setState(() => _intensity = v);
                                  },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading
                  ? null
                  : () async {
                      final messenger = ScaffoldMessenger.of(context);
                      bool flag = true;
                      if (_intensity.toInt() >= 50 && _selectedType == StimulusType.zap) {
                        if (_intensity.toInt() > 65) {
                          _intensity = 65;
                        }
                        flag = await _confirmZap(context, 1);
                        if (flag && _intensity.toInt() >= 60) {
                          flag = await _confirmZap(context, 2);
                        }
                        if (flag && _intensity.toInt() >= 65) {
                          flag = await _confirmZap(context, 3);
                        }
                        if (flag && _intensity.toInt() >= 75) {
                          flag = await _confirmZap(context, 4);
                        }
                        if (flag && _intensity.toInt() >= 80) {
                          flag = await _confirmZap(context, 5);
                        }
                        if (flag && _intensity.toInt() >= 90) {
                          flag = await _confirmZap(context, 6);
                        }
                        if (flag && _intensity.toInt() >= 95) {
                          flag = await _confirmZap(context, 7);
                        }
                      }
                      if (!flag) return;

                      await ref.read(stimulusNotifierProvider.notifier).send(
                            type: _selectedType,
                            value: _intensity.toInt(),
                          );

                      if (!mounted) return;

                      final error = ref.read(stimulusNotifierProvider).error;

                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            error != null
                                ? error.toString()
                                : '${_selectedType.name.toUpperCase()} sent!',
                          ),
                          backgroundColor: error != null
                              ? const Color(0xFFFF3B30)
                              : const Color(0xFF34C759),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(12),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.bolt_rounded),
                              const SizedBox(width: 8),
                              Text(
                                'Send ${_selectedType.name.toUpperCase()}',
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                  ),
                ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmZap(BuildContext context, int severity) async {
    final bol = List.filled(severity, '⚡').join();
    final showMax = _intensity.toInt() >= 65 ? '\n\nMAX 65%' : '';
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Confirm Zap? $bol',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'You are going to zap at ${_intensity.toInt()}% intensity! ${showMax}',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF4DA6FF)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              'Confirm',
              style: TextStyle(color: Color(0xFFFF3B30)),
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}

class _ArcPainter extends CustomPainter {
  final double value;
  final double max;
  final Color color;

  _ArcPainter({required this.value, required this.max, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 18;
    const startAngle = pi * 0.75;
    const sweepAngle = pi * 1.5;

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    final fraction = (value / max).clamp(0.0, 1.0);
    if (fraction > 0) {
      final activePaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 14
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle * fraction,
        false,
        activePaint,
      );

      final tipAngle = startAngle + sweepAngle * fraction;
      final tipX = center.dx + radius * cos(tipAngle);
      final tipY = center.dy + radius * sin(tipAngle);

      final glowPaint = Paint()
        ..color = color.withOpacity(0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(Offset(tipX, tipY), 10, glowPaint);

      final dotPaint = Paint()..color = Colors.white;
      canvas.drawCircle(Offset(tipX, tipY), 5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_ArcPainter old) => old.value != value || old.color != color;
}

class _TypeButton extends StatelessWidget {
  final StimulusType type;
  final IconData icon;
  final String label;
  final Color color;
  final StimulusType selected;
  final ValueChanged<StimulusType> onTap;

  const _TypeButton({
    required this.type,
    required this.icon,
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == type;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap(type);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [color.withOpacity(0.28), color.withOpacity(0.12)],
                    )
                  : null,
              color: isSelected ? null : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? color.withOpacity(0.6) : Colors.white.withOpacity(0.08),
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.15 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  child: Icon(icon, color: isSelected ? color : Colors.white38, size: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? color : Colors.white38,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DarkGlassSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _DarkGlassSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
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
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 6)),
                ],
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
