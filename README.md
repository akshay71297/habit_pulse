# HabitPulse

A cross-platform Flutter app for managing good and bad habits, tightly integrated with the **Pavlok** wearable API. Track your streaks, automate stimuli (zap, vibe, buzz, beep), and stay accountable.

---

## Features

- **Habit Tracking**
  - Create good and bad habits
  - Daily streak counting with best-streak records
  - One-tap completion with optional Pavlok feedback

- **Pavlok Integration**
  - Secure API token storage
  - Manual stimulus controls with intensity slider (1-255)
  - Connection testing and diagnostics
  - Offline queue: stimuli are saved and sent when connectivity returns

- **Scheduling & Automation**
  - Schedule any stimulus for a specific date/time
  - Recurring schedules: every N minutes, hours, or days
  - Optional end dates
  - Background execution checks every 15 minutes
  - Local notifications on stimulus delivery

- **Stability & Quality**
  - Retry logic with exponential backoff on all API calls
  - Comprehensive structured logging
  - SQLite persistence for habits, schedules, and logs
  - Material 3 design with light/dark mode support
  - Smooth animations and polished UX

---

## Project Structure

```
lib/
  main.dart                      # App entry point
  src/
    core/
      constants/                 # App constants, enums
      theme/                     # Light & dark themes (FlexColorScheme)
      utils/                     # Extensions
      services/                  # Logger
    models/                      # Freezed models: Habit, ScheduledStimulus, etc.
    database/                    # SQLite helper + DAOs
    services/                    # Pavlok API, notifications, background tasks
    providers/                   # Riverpod state management
    screens/                     # UI screens
    widgets/                     # Shared widgets
```

---

## Setup & Build

### Prerequisites
- Flutter SDK (stable channel)
- Android Studio / Xcode (for mobile builds)

### Install Dependencies
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Run
```bash
# Linux desktop (for development)
flutter run -d linux

# Android
flutter run

# iOS (macOS only)
flutter run -d ios
```

### Build Release
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## Configuration

1. Open the app and go to **Settings**
2. Paste your Pavlok API token (get it from the [Pavlok Developer Portal](https://pavlok.readme.io/))
3. Tap **Save & Test** to verify connectivity

---

## Pavlok API Reference

- Base URL: `https://api.pavlok.com/api/v5`
- Auth: Bearer token
- Send stimulus: `POST /stimulus/send`
  ```json
  {
    "stimulus": {
      "stimulusType": "zap",
      "stimulusValue": 50
    }
  }
  ```

---

## Background Tasks

The app uses `workmanager` to periodically check for pending scheduled stimuli. On Android this runs reliably in the background. On iOS, background execution is subject to OS scheduling policies and may be less frequent.

---

## Data & Privacy

All data is stored locally on your device. No data is sent anywhere except directly to the Pavlok API when you explicitly trigger a stimulus or a scheduled task runs.
