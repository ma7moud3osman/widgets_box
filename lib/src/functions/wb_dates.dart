import 'package:intl/intl.dart';
import 'package:smart_localize/smart_localize.dart';

/// Namespaced calendar helpers that don't depend on a [BuildContext].
///
/// Groups the day-comparison and "Today / Yesterday / …" labelling every app
/// re-implements. Human labels are localized through `smart_localize`; raw
/// formatting delegates to `intl`'s [DateFormat] so it follows `Intl.locale`.
abstract final class WBDates {
  /// Whether [a] and [b] fall on the same calendar day.
  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Whether [date] is today.
  static bool isToday(DateTime date) => isSameDay(date, DateTime.now());

  /// Midnight at the start of [date]'s day.
  static DateTime startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  /// Number of whole calendar days from today to [date] (negative = past).
  static int daysFromToday(DateTime date) =>
      startOfDay(date).difference(startOfDay(DateTime.now())).inDays;

  /// A short, human day label: localized `Today` / `Yesterday` / `Tomorrow`
  /// for adjacent days, otherwise [date] formatted with [pattern]
  /// (defaults to `EEE, d MMM`, e.g. `Mon, 5 Aug`).
  static String dayLabel(DateTime date, {String pattern = 'EEE, d MMM'}) {
    switch (daysFromToday(date)) {
      case 0:
        return SmartLocalize.today;
      case -1:
        return SmartLocalize.yesterday;
      case 1:
        return SmartLocalize.tomorrow;
      default:
        return DateFormat(pattern).format(date);
    }
  }

  /// Formats [date] with [pattern] (an `intl` [DateFormat] skeleton/pattern).
  static String format(DateTime date, {String pattern = 'dd/MM/yyyy'}) =>
      DateFormat(pattern).format(date);
}
