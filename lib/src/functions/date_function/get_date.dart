import 'dart:developer';

import 'package:intl/intl.dart';

import 'date_format.dart';

String getFormatedDate({
  required String? date,
  DateFormats? format,
  bool toApi = true,
  bool isUTC = true,
  String locale = 'en_US',
}) {
  final dateTime = DateTime.tryParse(date ?? '');
  if (dateTime == null) {
    return '';
  }
  try {
    return DateFormat(
      format?.format ?? DateFormats.dateApi.format,
      toApi ? 'en_US' : locale,
    ).format(isUTC ? dateTime.toLocal() : dateTime);
  } catch (e) {
    log(e.toString());
    return "";
  }
}

/// Time format String must be 'HH:mm'
String getTime({
  required String? time,
  String? format,
  bool toApi = true,
  String locale = 'en_US',
}) {
  if (time == null) return '';
  try {
    int hours, minutes;
    if (time.contains(RegExp(r'(AM|PM|ص|م)', caseSensitive: false))) {
      // Handle 12-hour format
      final period = time.split(' ')[1].toUpperCase(); // Extract AM/PM
      final rawTime = time.split(' ')[0]; // Extract time (e.g., "11:00")
      hours = int.parse(rawTime.split(':')[0].trim());
      minutes = int.parse(rawTime.split(':')[1].trim());
      // Adjust hours for 12-hour format
      hours = (period == 'PM' || period == 'م') && hours != 12
          ? hours + 12
          : ((period == 'AM' || period == 'ص') && hours == 12 ? 0 : hours);
    } else {
      // Handle 24-hour format
      hours = int.parse(time.split(':')[0].trim());
      minutes = int.parse(time.split(':')[1].trim());
    }
    final dateTime = DateTime.now().copyWith(hour: hours, minute: minutes);
    return DateFormat.jm(toApi ? 'en_US' : locale).format(dateTime);
  } catch (e) {
    log(e.toString());
    return "";
  }
}

int getDurationDays({required String date, String? secondDate}) {
  try {
    final startDate = secondDate != null
        ? DateTime.parse(secondDate)
        : DateTime.now();
    final dateTime = DateTime.tryParse(date)?.toLocal() ?? startDate;
    final difference = dateTime.difference(startDate).inDays;
    return difference.abs() + 1;
  } catch (e) {
    log(e.toString());
    return 1;
  }
}

String getDateTime({
  required String date,
  String? format,
  bool toApi = true,
  bool isUTC = true,
  String locale = 'en_US',
}) {
  try {
    return DateFormat(
      format ?? DateFormats.dateTime.format,
      toApi ? 'en_US' : locale,
    ).format(
      isUTC
          ? DateTime.tryParse(date)?.toLocal() ?? DateTime.now()
          : DateTime.tryParse(date) ?? DateTime.now(),
    );
  } catch (e) {
    log(e.toString());
    return "";
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

extension DateTimeExtension on DateTime {
  DateTime get midnight => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59);

  String get toApi => toUtc().toIso8601String();
}
