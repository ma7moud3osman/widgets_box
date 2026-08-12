import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_box/widgets_box.dart';

void main() {
  group('validators', () {
    test('email', () {
      expect(validateEmailFormat('a@b.co'), isNull);
      expect(validateEmailFormat(''), isNotNull);
      expect(validateEmailFormat('nope'), isNotNull);
    });

    test('phone', () {
      expect(validatePhoneFormat(''), isNotNull);
      expect(validatePhoneFormat('123'), isA<String?>());
      expect(validatePhoneFormat('01000000000'), isA<String?>());
    });

    test('non-empty', () {
      expect(validateNonEmptyFormat('x'), isNull);
      expect(validateNonEmptyFormat(''), isNotNull);
      expect(validateNonEmptyFormat('0'), isNotNull);
    });

    test('number', () {
      expect(validateNumberFormat('12'), isNull);
      expect(validateNumberFormat('12.5'), isNull);
      expect(validateNumberFormat(''), isNotNull);
      expect(validateNumberFormat('abc'), isNotNull);
    });

    test('password', () {
      expect(validatePasswordFormat(''), isNotNull);
      expect(validatePasswordFormat('short'), isNotNull);
      expect(validatePasswordFormat('Abcdef1!'), isA<String?>());
    });

    test('confirm password', () {
      expect(
        validateConfirmPasswordFormat(confirmPassword: 'abc', password: 'xyz'),
        isNotNull,
      );
      expect(
        validateConfirmPasswordFormat(confirmPassword: '', password: 'x'),
        isNotNull,
      );
      expect(
        validateConfirmPasswordFormat(confirmPassword: 'same', password: 'same'),
        isNull,
      );
    });

    test('description / arabic / english / time', () {
      expect(validateDescription(''), isNotNull);
      expect(validateDescription('a valid description'), isA<String?>());
      expect(validateArabic('مرحبا'), isA<String?>());
      expect(validateArabic('abc'), isNotNull);
      expect(validateEnglish('hello'), isA<String?>());
      expect(validateEnglish('عربي'), isNotNull);
      expect(validateTimeFormat(''), isNotNull);
      expect(validateTimeFormat('11:00'), isA<String?>());
    });
  });
}
