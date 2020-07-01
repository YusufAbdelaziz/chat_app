import 'package:flutter/foundation.dart';

extension DateTimeExtension on DateTime {
  static bool isToday({@required DateTime date}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final givenDate = DateTime(date.year, date.month, date.day);
    return givenDate == today;
  }

  static bool isYesterday({@required DateTime date}) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final givenDate = DateTime(date.year, date.month, date.day);
    return givenDate == yesterday;
  }
}
