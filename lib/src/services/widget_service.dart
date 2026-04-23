import 'package:home_widget/home_widget.dart';
import 'package:habit_pulse/src/core/services/logger_service.dart';

/// Service for managing the Android home screen widget.
/// The widget itself handles Pavlok API calls natively for reliability,
/// but this service can be used to update widget state from Flutter.
class WidgetService {
  static const String _appGroupId = 'com.yourname.habit_pulse';

  static Future<void> initialize() async {
    try {
      await HomeWidget.setAppGroupId(_appGroupId);
      LoggerService.info('WidgetService initialized');
    } catch (e, st) {
      LoggerService.error('WidgetService init failed', e, st);
    }
  }

  /// Updates widget data that can be displayed in the widget.
  static Future<void> updateWidget({
    String? lastStimulusType,
    String? lastStimulusTime,
  }) async {
    try {
      if (lastStimulusType != null) {
        await HomeWidget.saveWidgetData('last_stimulus_type', lastStimulusType);
      }
      if (lastStimulusTime != null) {
        await HomeWidget.saveWidgetData('last_stimulus_time', lastStimulusTime);
      }
      await HomeWidget.updateWidget(
        name: 'StimulusWidgetProvider',
        androidName: 'StimulusWidgetProvider',
      );
      LoggerService.info('WidgetService: widget updated');
    } catch (e, st) {
      LoggerService.error('WidgetService update failed', e, st);
    }
  }
}
