# Graph Report - .  (2026-04-22)

## Corpus Check
- Corpus is ~27,841 words - fits in a single context window. You may not need a graph.

## Summary
- 462 nodes · 561 edges · 32 communities detected
- Extraction: 91% EXTRACTED · 9% INFERRED · 0% AMBIGUOUS · INFERRED: 48 edges (avg confidence: 0.82)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Habit Form Screen|Habit Form Screen]]
- [[_COMMUNITY_Riverpod State Providers|Riverpod State Providers]]
- [[_COMMUNITY_App Entry & Theme|App Entry & Theme]]
- [[_COMMUNITY_Background Services & Routing|Background Services & Routing]]
- [[_COMMUNITY_App Constants & Enums|App Constants & Enums]]
- [[_COMMUNITY_Freezed Data Models|Freezed Data Models]]
- [[_COMMUNITY_Database DAO Layer|Database DAO Layer]]
- [[_COMMUNITY_App Icons & Branding|App Icons & Branding]]
- [[_COMMUNITY_App Theme & Linux Flutter View|App Theme & Linux Flutter View]]
- [[_COMMUNITY_Flutter Linux Channel API|Flutter Linux Channel API]]
- [[_COMMUNITY_Database Helper Core|Database Helper Core]]
- [[_COMMUNITY_Linux CMake Build|Linux CMake Build]]
- [[_COMMUNITY_Stimulus Screen UI|Stimulus Screen UI]]
- [[_COMMUNITY_Platform Plugin Registration|Platform Plugin Registration]]
- [[_COMMUNITY_Logger Service|Logger Service]]
- [[_COMMUNITY_PavlokSettings Freezed|PavlokSettings Freezed]]
- [[_COMMUNITY_Habit Freezed Model|Habit Freezed Model]]
- [[_COMMUNITY_ScheduledStimulus Freezed|ScheduledStimulus Freezed]]
- [[_COMMUNITY_StimulusLog Freezed|StimulusLog Freezed]]
- [[_COMMUNITY_Android Plugin Registrant|Android Plugin Registrant]]
- [[_COMMUNITY_iOS Unit Tests|iOS Unit Tests]]
- [[_COMMUNITY_iOS AppDelegate|iOS AppDelegate]]
- [[_COMMUNITY_Flutter Linux Message Codecs|Flutter Linux Message Codecs]]
- [[_COMMUNITY_AppConstants File|AppConstants File]]
- [[_COMMUNITY_Android MainActivity|Android MainActivity]]
- [[_COMMUNITY_iOS Bridging Header|iOS Bridging Header]]
- [[_COMMUNITY_DateTime Extensions|DateTime Extensions]]
- [[_COMMUNITY_BuildContext Extensions|BuildContext Extensions]]
- [[_COMMUNITY_FL Method Codec|FL Method Codec]]
- [[_COMMUNITY_Project README|Project README]]
- [[_COMMUNITY_Launch Image README|Launch Image README]]
- [[_COMMUNITY_Launch Image Asset|Launch Image Asset]]

## God Nodes (most connected - your core abstractions)
1. `Flutter Default App Icon Design - light blue (#54C5F8) diagonal chevron kite with dark navy (#01579B) lower accent on white background; indicates app has not yet received custom branding` - 20 edges
2. `flutter_linux.h (umbrella header)` - 18 edges
3. `package:habit_pulse/src/core/constants/app_constants.dart` - 15 edges
4. `package:flutter_riverpod/flutter_riverpod.dart` - 13 edges
5. `package:flutter/material.dart` - 12 edges
6. `iOS GeneratedPluginRegistrant` - 10 edges
7. `linux/flutter/CMakeLists.txt` - 10 edges
8. `package:habit_pulse/src/core/services/logger_service.dart` - 9 edges
9. `Habit` - 9 edges
10. `Android GeneratedPluginRegistrant` - 9 edges

## Surprising Connections (you probably didn't know these)
- `HabitPulse App` --conceptually_related_to--> `flutter_linux.h (umbrella header)`  [INFERRED]
  README.md → linux/flutter/ephemeral/flutter_linux/flutter_linux.h
- `FlDartProject (Dart project configuration)` --conceptually_related_to--> `HabitPulse App`  [INFERRED]
  linux/flutter/ephemeral/flutter_linux/fl_dart_project.h → README.md
- `HabitPulse iOS Application - Flutter-based habit tracking app targeting iOS platform` --semantically_similar_to--> `HabitPulse Android Application - Flutter-based habit tracking app targeting Android platform`  [INFERRED] [semantically similar]
  ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png → android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
- `App renders without crashing (widget test)` --references--> `appRouter (GoRouter)`  [INFERRED]
  test/widget_test.dart → lib/src/router/app_router.dart
- `Linux CMakeLists.txt (habit_pulse build config)` --references--> `flutter_linux.h (umbrella header)`  [INFERRED]
  linux/CMakeLists.txt → linux/flutter/ephemeral/flutter_linux/flutter_linux.h

## Hyperedges (group relationships)
- **Riverpod Provider wrapping DAO pattern** — database_providers_databasehelperprovider, database_providers_habitdaoprovider, database_providers_scheduledstimulsdaoprovider, database_providers_stimuluslogdaoprovider, database_providers_settingsdaoprovider [EXTRACTED 0.95]
- **Freezed immutable data model layer** — habit_habit, pavlok_settings_pavloksettings, scheduled_stimulus_scheduledstimulus, stimulus_log_stimuluslog [EXTRACTED 1.00]
- **App-wide enums defined in AppConstants file** — app_constants_stimulustype, app_constants_habittype, app_constants_schedulerepeatunit [EXTRACTED 1.00]
- **Habit read and write providers consuming habitDaoProvider** — habit_provider_habitsprovider, habit_provider_goodhabitsprovider, habit_provider_badhabitsprovider, habit_provider_habitbyidprovider, habit_provider_habitnotifier, habit_provider_habitnotifierprovider [INFERRED 0.90]
- **Settings and Pavlok API providers forming settings management layer** — settings_provider_pavloksettingsprovider, settings_provider_pavlokapiserviceprovider, settings_provider_settingsnotifier, settings_provider_settingsnotifierprovider [INFERRED 0.90]
- **Background Scheduled Stimulus Execution Pipeline** — background_handler_callbackDispatcher, scheduled_stimulus_dao_ScheduledStimulusDao, pavlok_api_service_PavlokApiService, stimulus_log_dao_StimulusLogDao, notification_service_NotificationService, settings_dao_SettingsDao, database_helper_DatabaseHelper [EXTRACTED 0.95]
- **DAO Layer (all DAOs share DatabaseHelper)** — habit_dao_HabitDao, scheduled_stimulus_dao_ScheduledStimulusDao, stimulus_log_dao_StimulusLogDao, settings_dao_SettingsDao, database_helper_DatabaseHelper [EXTRACTED 1.00]
- **Stimulus Send Flow (manual + scheduled)** — stimulus_provider_StimulusNotifier, pavlok_api_service_PavlokApiService, stimulus_log_dao_StimulusLogDao, notification_service_NotificationService [EXTRACTED 0.95]
- **App Navigation Shell (router + shell + screens)** — app_router_appRouter, home_shell_HomeShell, habits_screen_HabitsScreen, stimulus_screen_StimulusScreen, schedule_screen_ScheduleScreen, settings_screen_SettingsScreen [EXTRACTED 1.00]
- **Cross-platform plugin registration: connectivity_plus, flutter_local_notifications, package_info_plus, path_provider, shared_preferences, sqflite, workmanager** — ios_generated_plugin_registrant, android_generated_plugin_registrant, linux_generated_plugin_registrant_cc, plugin_connectivity_plus, plugin_flutter_local_notifications, plugin_package_info_plus, plugin_path_provider, plugin_shared_preferences, plugin_sqflite, plugin_workmanager [INFERRED 0.95]
- **Linux Flutter message codec types (JSON, Standard, Method)** — fl_json_message_codec_h, fl_standard_message_codec_h, fl_method_codec_h, fl_basic_message_channel_h [INFERRED 0.85]
- **Linux application entry point chain: main -> MyApplication -> FlView -> fl_register_plugins** — linux_main_cc, linux_my_application_cc, fl_view_h, linux_generated_plugin_registrant_cc [EXTRACTED 1.00]
- **Flutter Linux Platform Channel System** — fl_binary_messenger_h, fl_method_channel_h, fl_event_channel_h, fl_method_call_h, fl_method_response_h, fl_value_h [INFERRED 0.90]
- **Flutter Linux Codec Hierarchy** — fl_message_codec_h, fl_binary_codec_h, fl_string_codec_h, fl_standard_method_codec_h, fl_json_method_codec_h, fl_method_codec_concept [INFERRED 0.90]
- **Flutter Linux Texture System** — fl_texture_h, fl_texture_gl_h, fl_pixel_buffer_texture_h [INFERRED 0.88]
- **Flutter Linux Public API (all headers)** — flutter_linux_h, fl_method_channel_h, fl_texture_h, fl_binary_codec_h, fl_string_codec_h, fl_plugin_registrar_h, fl_binary_messenger_h, fl_method_call_h, fl_value_h, fl_pixel_buffer_texture_h, fl_message_codec_h, fl_event_channel_h, fl_method_response_h, fl_texture_gl_h, fl_dart_project_h, fl_standard_method_codec_h, fl_json_method_codec_h [EXTRACTED 1.00]
- **Flutter Linux CMake build system** — cmakelists_flutter, flutter_target, flutter_assemble_target, flutter_tool_backend, flutter_library, flutter_library_headers, gtk_dep, glib_dep, gio_dep [INFERRED 0.90]
- **iOS AppIcon Set - all resolution variants of the iOS app icon sharing identical Flutter default logo design** — icon_app_20x20_1x_appicon, icon_app_20x20_2x_appicon, icon_app_20x20_3x_appicon, icon_app_29x29_1x_appicon, icon_app_29x29_2x_appicon, icon_app_29x29_3x_appicon, icon_app_40x40_1x_appicon, icon_app_40x40_2x_appicon, icon_app_40x40_3x_appicon, icon_app_60x60_2x_appicon, icon_app_60x60_3x_appicon, icon_app_83_5x83_5_2x_appicon, icon_app_1024x1024_1x_appicon [EXTRACTED 1.00]
- **iOS Launch Image Set - all resolution variants of the blank white Flutter launch image placeholder** — launchimage_1x_launchimage, launchimage_2x_launchimage, launchimage_3x_launchimage, launchimage_4x_launchimage [EXTRACTED 1.00]
- **Android Launcher Icon Set - all density bucket variants of the Android launcher icon sharing Flutter default logo design** — ic_launcher_mdpi_androidicon, ic_launcher_hdpi_androidicon, ic_launcher_xhdpi_androidicon, ic_launcher_xxhdpi_androidicon, ic_launcher_xxxhdpi_androidicon [EXTRACTED 1.00]
- **Flutter Default Branding - all app icons across iOS and Android that display the unmodified Flutter default logo, indicating no custom branding has been applied to HabitPulse** — icon_app_1024x1024_1x_appicon, ic_launcher_xxxhdpi_androidicon, ic_launcher_hdpi_androidicon, flutter_default_logo_concept, habit_pulse_ios_app_concept, habit_pulse_android_app_concept [INFERRED 0.90]

## Communities

### Community 0 - "Habit Form Screen"
Cohesion: 0.04
Nodes (53): build, dispose, HabitFormScreen, _HabitFormScreenState, initState, _loadHabit, Scaffold, SizedBox (+45 more)

### Community 1 - "Riverpod State Providers"
Cohesion: 0.07
Nodes (34): HabitDao, ScheduledStimulusDao, SettingsDao, StimulusLogDao, HabitNotifier, ScheduledStimulusNotifier, PavlokError, PavlokSuccess (+26 more)

### Community 2 - "App Entry & Theme"
Cohesion: 0.06
Nodes (29): build, HabitPulseApp, main, AppTheme, darkTheme, lightTheme, showSnackBar, toDateString (+21 more)

### Community 3 - "Background Services & Routing"
Cohesion: 0.11
Nodes (30): appRouter (GoRouter), callbackDispatcher (Workmanager top-level callback), BackgroundTaskService, DatabaseHelper (singleton), HabitDao, HabitFormScreen (ConsumerStatefulWidget), HabitsScreen (ConsumerWidget), HomeShell (ConsumerStatefulWidget) (+22 more)

### Community 4 - "App Constants & Enums"
Cohesion: 0.12
Nodes (26): AppConstants, HabitType, ScheduleRepeatUnit, StimulusType, databaseHelperProvider, habitDaoProvider, scheduledStimulusDaoProvider, settingsDaoProvider (+18 more)

### Community 5 - "Freezed Data Models"
Cohesion: 0.09
Nodes (20): dart:async, Habit, PavlokSettings, ScheduledStimulus, StimulusLog, _executeStimulus, _formatDioError, _isRetryable (+12 more)

### Community 6 - "Database DAO Layer"
Cohesion: 0.1
Nodes (20): _fromMap, HabitDao, _fromMap, ScheduledStimulusDao, _fromMap, SettingsDao, _fromMap, StimulusLogDao (+12 more)

### Community 7 - "App Icons & Branding"
Cohesion: 0.09
Nodes (24): Flutter Default App Icon Design - light blue (#54C5F8) diagonal chevron kite with dark navy (#01579B) lower accent on white background; indicates app has not yet received custom branding, HabitPulse Android Application - Flutter-based habit tracking app targeting Android platform, HabitPulse iOS Application - Flutter-based habit tracking app targeting iOS platform, Android Launcher Icon hdpi (72px) - Flutter default logo, light blue diagonal chevron with dark navy accent, white background, Android Launcher Icon mdpi (48px) - Flutter default logo, light blue diagonal chevron with navy accent, Android Launcher Icon xhdpi (96px) - Flutter default logo, light blue diagonal chevron with navy accent, Android Launcher Icon xxhdpi (144px) - Flutter default logo, light blue diagonal chevron with navy accent, Android Launcher Icon xxxhdpi (192px) - Flutter default logo, light blue diagonal chevron with dark navy accent, white background (+16 more)

### Community 8 - "App Theme & Linux Flutter View"
Cohesion: 0.1
Nodes (13): AppTheme, FlEngine Header, FlPluginRegistry Header, FlTextureRegistrar Header, FlView Header, fl_register_plugins(), dispose, Linux Generated Plugin Registrant Header (+5 more)

### Community 9 - "Flutter Linux Channel API"
Cohesion: 0.2
Nodes (22): FlBinaryCodec (binary message codec), FlBinaryMessenger (platform message transport), FlDartProject (Dart project configuration), FlEventChannel (event stream channel to Dart), FlJsonMethodCodec (JSON method codec), FlMessageCodec (base message codec), FlMethodCall (incoming method call object), FlMethodChannel (method call bidirectional channel) (+14 more)

### Community 10 - "Database Helper Core"
Cohesion: 0.11
Nodes (16): dart:io, dart:math, CHECK, DatabaseHelper, habits, KEY, openDatabase, pavlok_settings (+8 more)

### Community 11 - "Linux CMake Build"
Cohesion: 0.22
Nodes (14): build/lib/libapp.so (AOT library), linux/flutter/CMakeLists.txt, flutter_assemble (custom target), flutter/flutter issue #57146, libflutter_linux_gtk.so, Flutter Linux headers (fl_*.h, flutter_linux.h), flutter (INTERFACE library target), flutter_tools/bin/tool_backend.sh (+6 more)

### Community 12 - "Stimulus Screen UI"
Cohesion: 0.15
Nodes (12): _ActionButton, build, Expanded, Icon, Row, Scaffold, SizedBox, Spacer (+4 more)

### Community 13 - "Platform Plugin Registration"
Cohesion: 0.26
Nodes (13): Android GeneratedPluginRegistrant, Android MainActivity, iOS AppDelegate, iOS GeneratedPluginRegistrant, iOS RunnerTests, Linux Generated Plugin Registrant Implementation, connectivity_plus Plugin, flutter_local_notifications Plugin (+5 more)

### Community 14 - "Logger Service"
Cohesion: 0.29
Nodes (6): debug, error, info, LoggerService, warning, package:logger/logger.dart

### Community 15 - "PavlokSettings Freezed"
Cohesion: 0.5
Nodes (5): identical, _PavlokSettings, _then, toString, _

### Community 16 - "Habit Freezed Model"
Cohesion: 0.5
Nodes (5): _Habit, identical, _then, toString, _

### Community 17 - "ScheduledStimulus Freezed"
Cohesion: 0.5
Nodes (5): identical, _ScheduledStimulus, _then, toString, _

### Community 18 - "StimulusLog Freezed"
Cohesion: 0.5
Nodes (5): identical, _StimulusLog, _then, toString, _

### Community 19 - "Android Plugin Registrant"
Cohesion: 0.4
Nodes (2): GeneratedPluginRegistrant, -registerWithRegistry

### Community 20 - "iOS Unit Tests"
Cohesion: 0.5
Nodes (2): RunnerTests, XCTestCase

### Community 21 - "iOS AppDelegate"
Cohesion: 0.5
Nodes (2): AppDelegate, FlutterAppDelegate

### Community 22 - "Flutter Linux Message Codecs"
Cohesion: 0.67
Nodes (3): FlBasicMessageChannel Header, FlJsonMessageCodec Header, FlStandardMessageCodec Header

### Community 23 - "AppConstants File"
Cohesion: 1.0
Nodes (1): AppConstants

### Community 24 - "Android MainActivity"
Cohesion: 1.0
Nodes (1): MainActivity

### Community 35 - "iOS Bridging Header"
Cohesion: 1.0
Nodes (2): iOS GeneratedPluginRegistrant Header, iOS Runner Bridging Header

### Community 58 - "DateTime Extensions"
Cohesion: 1.0
Nodes (1): DateTimeFormatting

### Community 59 - "BuildContext Extensions"
Cohesion: 1.0
Nodes (1): BuildContextExtensions

### Community 60 - "FL Method Codec"
Cohesion: 1.0
Nodes (1): FlMethodCodec Header

### Community 61 - "Project README"
Cohesion: 1.0
Nodes (1): HabitPulse README (project overview)

### Community 62 - "Launch Image README"
Cohesion: 1.0
Nodes (1): Launch Screen Assets README (iOS)

### Community 63 - "Launch Image Asset"
Cohesion: 1.0
Nodes (1): iOS Launch Image @4x - blank white image, no visible content (default Flutter launch placeholder)

## Knowledge Gaps
- **235 isolated node(s):** `HabitPulseApp`, `main`, `build`, `package:habit_pulse/src/core/theme/app_theme.dart`, `package:habit_pulse/src/router/app_router.dart` (+230 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Android Plugin Registrant`** (5 nodes): `GeneratedPluginRegistrant.java`, `GeneratedPluginRegistrant`, `.registerWith()`, `-registerWithRegistry`, `GeneratedPluginRegistrant.m`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `iOS Unit Tests`** (4 nodes): `RunnerTests.swift`, `RunnerTests`, `.testExample()`, `XCTestCase`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `iOS AppDelegate`** (4 nodes): `AppDelegate`, `.application()`, `FlutterAppDelegate`, `AppDelegate.swift`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `AppConstants File`** (2 nodes): `AppConstants`, `app_constants.dart`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Android MainActivity`** (2 nodes): `MainActivity.kt`, `MainActivity`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `iOS Bridging Header`** (2 nodes): `iOS GeneratedPluginRegistrant Header`, `iOS Runner Bridging Header`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `DateTime Extensions`** (1 nodes): `DateTimeFormatting`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `BuildContext Extensions`** (1 nodes): `BuildContextExtensions`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `FL Method Codec`** (1 nodes): `FlMethodCodec Header`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Project README`** (1 nodes): `HabitPulse README (project overview)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Launch Image README`** (1 nodes): `Launch Screen Assets README (iOS)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Launch Image Asset`** (1 nodes): `iOS Launch Image @4x - blank white image, no visible content (default Flutter launch placeholder)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `package:habit_pulse/src/core/constants/app_constants.dart` connect `Freezed Data Models` to `Habit Form Screen`, `Riverpod State Providers`, `Database DAO Layer`, `Database Helper Core`, `Stimulus Screen UI`?**
  _High betweenness centrality (0.091) - this node is a cross-community bridge._
- **Why does `package:flutter/material.dart` connect `App Entry & Theme` to `Habit Form Screen`, `Riverpod State Providers`, `Stimulus Screen UI`?**
  _High betweenness centrality (0.076) - this node is a cross-community bridge._
- **Why does `dispose` connect `App Theme & Linux Flutter View` to `Riverpod State Providers`?**
  _High betweenness centrality (0.069) - this node is a cross-community bridge._
- **Are the 2 inferred relationships involving `Flutter Default App Icon Design - light blue (#54C5F8) diagonal chevron kite with dark navy (#01579B) lower accent on white background; indicates app has not yet received custom branding` (e.g. with `HabitPulse iOS Application - Flutter-based habit tracking app targeting iOS platform` and `HabitPulse Android Application - Flutter-based habit tracking app targeting Android platform`) actually correct?**
  _`Flutter Default App Icon Design - light blue (#54C5F8) diagonal chevron kite with dark navy (#01579B) lower accent on white background; indicates app has not yet received custom branding` has 2 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `flutter_linux.h (umbrella header)` (e.g. with `HabitPulse App` and `Linux CMakeLists.txt (habit_pulse build config)`) actually correct?**
  _`flutter_linux.h (umbrella header)` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `HabitPulseApp`, `main`, `build` to the rest of the system?**
  _235 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Habit Form Screen` be split into smaller, more focused modules?**
  _Cohesion score 0.04 - nodes in this community are weakly interconnected._