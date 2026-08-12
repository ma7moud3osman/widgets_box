import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:widgets_box/widgets_box.dart';

extension AppStringExtension on String? {
  String get toFormattedDate =>
      getFormatedDate(date: this, format: DateFormats.dateSlash);

  String get toTime => getFormatedDate(date: this, format: DateFormats.time);

  String get toDateTime =>
      getFormatedDate(date: this, format: DateFormats.dateTime);

  ({String countryCode, String number})? get parsePhoneNumber {
    if (this?.isEmpty ?? true) return null;
    try {
      var phoneToParse = this!;
      if (!phoneToParse.startsWith('+')) phoneToParse = '+$phoneToParse';
      final parsedParams = PhoneNumber.parse(phoneToParse);
      return (
        countryCode: '+${parsedParams.countryCode}',
        number: parsedParams.nsn,
      );
    } catch (_) {
      return null;
    }
  }
}
