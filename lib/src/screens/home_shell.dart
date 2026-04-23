import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeShell extends ConsumerStatefulWidget {
  final Widget child;
  const HomeShell({required this.child, super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _currentIndex = 0;

  final _routes = ['/habits', '/stimulus', '/schedule', '/settings'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).uri.path;
    final index = _routes.indexWhere((r) => location.startsWith(r));
    if (index != -1 && index != _currentIndex) {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Dark gradient base ───────────────────────────────────────────
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0A0A1E), // deep navy
                Color(0xFF15082E), // dark violet
                Color(0xFF0A1020), // dark blue-black
              ],
            ),
          ),
        ),
        // ── Glowing blobs (give BackdropFilter something to blur) ────────
        const Positioned(top: -120, right: -80, child: _Blob(color: Color(0xFF007AFF), size: 360, opacity: 0.28)),
        const Positioned(top: 300, left: -80, child: _Blob(color: Color(0xFFAF52DE), size: 280, opacity: 0.22)),
        const Positioned(bottom: 160, right: -60, child: _Blob(color: Color(0xFFFF3B30), size: 260, opacity: 0.18)),
        const Positioned(bottom: 420, left: 40, child: _Blob(color: Color(0xFF34C759), size: 200, opacity: 0.14)),
        // ── App shell ───────────────────────────────────────────────────
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: widget.child,
          bottomNavigationBar: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.white.withOpacity(0.12), width: 0.5),
                  ),
                ),
                child: NavigationBar(
                  backgroundColor: Colors.black.withOpacity(0.45),
                  elevation: 0,
                  indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.25),
                  indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) {
                    setState(() => _currentIndex = index);
                    context.go(_routes[index]);
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.fitness_center_outlined),
                      selectedIcon: Icon(Icons.fitness_center),
                      label: 'Habits',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.bolt_outlined),
                      selectedIcon: Icon(Icons.bolt),
                      label: 'Stimulus',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.schedule_outlined),
                      selectedIcon: Icon(Icons.schedule),
                      label: 'Schedule',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  final Color color;
  final double size;
  final double opacity;

  const _Blob({required this.color, required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(opacity),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: const SizedBox.expand(),
      ),
    );
  }
}
