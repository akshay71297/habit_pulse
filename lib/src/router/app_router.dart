import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_pulse/src/screens/home_shell.dart';
import 'package:habit_pulse/src/screens/habit_form_screen.dart';
import 'package:habit_pulse/src/screens/habits_screen.dart';
import 'package:habit_pulse/src/screens/schedule_form_screen.dart';
import 'package:habit_pulse/src/screens/schedule_screen.dart';
import 'package:habit_pulse/src/screens/settings_screen.dart';
import 'package:habit_pulse/src/screens/stimulus_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/habits',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeShell(child: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/habits',
              builder: (context, state) => const HabitsScreen(),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => const HabitFormScreen(),
                ),
                GoRoute(
                  path: 'edit/:id',
                  builder: (context, state) => HabitFormScreen(habitId: state.pathParameters['id']),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stimulus',
              builder: (context, state) => const StimulusScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/schedule',
              builder: (context, state) => const ScheduleScreen(),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => const ScheduleFormScreen(),
                ),
                GoRoute(
                  path: 'history',
                  builder: (context, state) => const Scaffold(body: Center(child: Text('History'))),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
