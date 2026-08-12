import 'package:flutter/material.dart';

import '../widgets/label_required_widget.dart';

/// Returns an `InputDecoration` based on the specified `DecorationType`.
///
/// This function provides different decoration styles (`outline`, `underline`, `filled`)
/// depending on the specified decoration type. It also allows for customization
/// of various properties such as icons, label text, hint text, padding, etc.
///
/// - Parameters:
///   - [context]: The current `BuildContext`, used to access theme properties.
///   - [isEnable]: Whether the input field is enabled or not.
///   - [labelText]: The label text to display above the input field.
///   - [hintText]: The hint text to display inside the input field.
///   - [prefixIcon]: A widget to display before the input text (usually an icon).
///   - [suffixIcon]: A widget to display after the input text (usually an icon).
///   - [contentPadding]: The padding inside the input field.
///   - [showAsterisk]: Whether to show an asterisk (*) for required fields (default is true).
///   - [isDense]: Whether to make the input field dense (compact spacing).
///   - [isRequired]: Whether the input field is required (shows an asterisk if `true`).
///
/// - Returns: An `InputDecoration` object with the appropriate configuration for the input field.
InputDecoration getInputDecoration({
  required BuildContext context,
  required bool isEnable,
  required String? labelText,
  required String? hintText,
  required Widget? prefixIcon,
  required Widget? suffixIcon,
  bool showAsterisk = true,
  bool isDense = false,
  bool isRequired = false,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? floatingLabelStyle,
  bool? filled,
  Color? fillColor,
  double? radius,
  Color? borderColor,
  Color? focusedBorderColor,
  double? borderWidth,
  Color? labelColor,
}) {
  // Borders are only built when the consumer opts in (a radius or border color
  // is supplied). Otherwise they are left null so the app's global
  // InputDecorationTheme keeps driving the look — this preserves the existing
  // appearance for every current consumer.
  final wantsBorder =
      radius != null || borderColor != null || borderWidth != null;
  OutlineInputBorder? borderFor(Color color) => wantsBorder
      ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: BorderSide(color: color, width: borderWidth ?? 1.0),
        )
      : null;

  final theme = Theme.of(context);
  final enabledColor = borderColor ?? theme.dividerColor;
  final focusedColor = focusedBorderColor ?? theme.colorScheme.primary;

  return InputDecoration(
    contentPadding: contentPadding ?? EdgeInsets.zero,
    isDense: isDense,
    enabled: isEnable,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: filled ?? (fillColor != null ? true : null),
    fillColor: fillColor,
    border: borderFor(enabledColor),
    enabledBorder: borderFor(enabledColor),
    focusedBorder: borderFor(focusedColor),
    label: labelText != null
        ? LabelRequiredWidget(
            label: labelText,
            isRequired: (isRequired && showAsterisk),
          )
        : null,
    counterText: '',
    floatingLabelStyle:
        floatingLabelStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: labelColor ?? Colors.grey.shade800,
        ),
  );
}
