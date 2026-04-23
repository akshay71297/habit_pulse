import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toFormattedString() => DateFormat('MMM d, y • h:mm a').format(this);
  String toDateString() => DateFormat('MMM d, y').format(this);
  String toTimeString() => DateFormat('h:mm a').format(this);
  String toShortDateString() => DateFormat('MM/dd/yy').format(this);
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get screenSize => MediaQuery.sizeOf(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : null,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(12),
      ),
    );
  }
}
