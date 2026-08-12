import '../text_field/functions/validation_functions.dart';

/// A discoverable, namespaced facade over the package's form validators.
///
/// Every app re-implements the same `emailValidation` / `passwordValidation` /
/// … free functions; this groups the package's existing (localized) validators
/// under one `WB`-prefixed type so `WBValidators.` autocompletes the whole set
/// without polluting the global namespace or colliding with app-local helpers.
///
/// Each method returns a localized error message (via `smart_localize`) or
/// `null` when the value is valid — the exact contract `TextFormField.validator`
/// expects:
///
/// ```dart
/// WBTextField.email(validator: WBValidators.email, controller: emailCtrl);
/// ```
abstract final class WBValidators {
  /// Non-empty + valid email format.
  static String? email(String? value) => validateEmailFormat(value);

  /// Non-empty + 8–12 digit phone (optional leading `+`).
  static String? phone(String? value) => validatePhoneFormat(value);

  /// Non-empty / non-zero — the generic "required field" check.
  static String? required(String? value) => validateNonEmptyFormat(value);

  /// Valid, non-negative number.
  static String? number(String? value) => validateNumberFormat(value);

  /// Password rules (length/complexity as defined by the package).
  static String? password(String? value) => validatePasswordFormat(value);

  /// Confirmation matches [password].
  static String? confirmPassword({
    required String? confirmPassword,
    required String? password,
  }) =>
      validateConfirmPasswordFormat(
        confirmPassword: confirmPassword,
        password: password,
      );

  /// Non-empty free-text description.
  static String? description(String? value) => validateDescription(value);

  /// Arabic-only text.
  static String? arabic(String? value) => validateArabic(value);

  /// English-only text.
  static String? english(String? value) => validateEnglish(value);

  /// Valid time string.
  static String? time(String? value) => validateTimeFormat(value);

  /// Valid, positive price.
  static String? price(String? value) => priceValidation(value);
}
