import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/core/utils/extensions.dart';
import 'package:habit_pulse/src/models/pavlok_settings.dart';
import 'package:habit_pulse/src/providers/settings_provider.dart';
import 'package:habit_pulse/src/providers/stimulus_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _tokenCtrl = TextEditingController();
  bool _obscureToken = true;
  bool _isSaving = false;

  @override
  void dispose() {
    _tokenCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(pavlokSettingsProvider);

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
                'Settings',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -0.5),
              ),
            ),
            Expanded(
              child: settingsAsync.when(
                data: (settings) {
                  if (_tokenCtrl.text.isEmpty && settings != null) {
                    _tokenCtrl.text = settings.apiToken;
                  }
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    _DarkGlassSection(
                      title: 'PAVLOK CONNECTION',
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextFormField(
                            controller: _tokenCtrl,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'API Token',
                              hintStyle: const TextStyle(color: Colors.white38, fontSize: 16),
                              border: InputBorder.none,
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      _obscureToken ? Icons.visibility_off : Icons.visibility,
                                      color: Colors.white54,
                                    ),
                                    onPressed: () => setState(() => _obscureToken = !_obscureToken),
                                  ),
                                  if (settings?.apiToken.isNotEmpty ?? false)
                                    IconButton(
                                      icon: const Icon(Icons.clear, color: Colors.white38),
                                      onPressed: () {
                                        _tokenCtrl.clear();
                                        ref.read(settingsNotifierProvider.notifier).clearToken();
                                      },
                                    ),
                                ],
                              ),
                            ),
                            obscureText: _obscureToken,
                            autocorrect: false,
                            enableSuggestions: false,
                          ),
                        ),
                        Divider(height: 1, indent: 16, color: Colors.white.withOpacity(0.1)),
                        InkWell(
                          onTap: _isSaving ? null : _saveAndTest,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            alignment: Alignment.center,
                            child: _isSaving
                                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                                : const Text(
                                    'Save & Test',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF4DA6FF)),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    if (settings?.lastTestedAt != null) ...[
                      const SizedBox(height: 16),
                      _buildStatusCard(settings!),
                    ],
                    const SizedBox(height: 24),
                    _DarkGlassSection(
                      title: 'DIAGNOSTICS',
                      children: [
                        _DarkRow(
                          icon: Icons.bug_report_outlined,
                          label: 'Test Stimulus',
                          onTap: () async {
                            final messenger = ScaffoldMessenger.of(context);
                            await ref.read(stimulusNotifierProvider.notifier).send(
                                  type: StimulusType.beep,
                                  value: 30,
                                );
                            if (mounted) {
                              final error = ref.read(stimulusNotifierProvider).error;
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(error == null ? 'Test beep sent!' : error.toString()),
                                  backgroundColor: error != null ? const Color(0xFFFF3B30) : const Color(0xFF34C759),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  margin: const EdgeInsets.all(12),
                                ),
                              );
                            }
                          },
                        ),
                        Divider(height: 1, indent: 16, color: Colors.white.withOpacity(0.1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline, size: 18, color: Colors.white38),
                              const SizedBox(width: 12),
                              const Text('Version', style: TextStyle(fontSize: 16, color: Colors.white70)),
                              const Spacer(),
                              const Text('1.0.0', style: TextStyle(fontSize: 16, color: Colors.white38)),
                            ],
                          ),
                        ),
                      ],
                    ),
                      ],
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

  Widget _buildStatusCard(PavlokSettings settings) {
    final success = settings.lastTestSuccess;
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: success ? const Color(0xFF34C759).withOpacity(0.15) : const Color(0xFFFF3B30).withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: success ? const Color(0xFF34C759).withOpacity(0.4) : const Color(0xFFFF3B30).withOpacity(0.4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    success ? Icons.check_circle_rounded : Icons.error_rounded,
                    color: success ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    success ? 'Connection OK' : 'Connection Failed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: success ? const Color(0xFF34C759) : const Color(0xFFFF3B30),
                    ),
                  ),
                ],
              ),
              if (settings.lastTestedAt != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Last tested: ${settings.lastTestedAt!.toLocal().toFormattedString()}',
                  style: const TextStyle(fontSize: 12, color: Colors.white54),
                ),
              ],
              if (!success && settings.lastErrorMessage != null) ...[
                const SizedBox(height: 8),
                Text(settings.lastErrorMessage!, style: const TextStyle(fontSize: 13, color: Color(0xFFFF6B6B))),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAndTest() async {
    setState(() => _isSaving = true);

    final settings = PavlokSettings(apiToken: _tokenCtrl.text.trim());
    await ref.read(settingsNotifierProvider.notifier).saveSettings(settings);

    final ok = await ref.read(settingsNotifierProvider.notifier).testConnection();

    if (mounted) {
      setState(() => _isSaving = false);
      context.showSnackBar(ok ? 'Connection successful!' : 'Connection failed. Check token.');
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
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 6))],
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Column(children: children)),
            ),
          ),
        ),
      ],
    );
  }
}

class _DarkRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DarkRow({required this.icon, required this.label, required this.onTap});

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
            Text(label, style: const TextStyle(fontSize: 16, color: Colors.white70)),
            const Spacer(),
            const Icon(Icons.chevron_right, size: 18, color: Colors.white30),
          ],
        ),
      ),
    );
  }
}
