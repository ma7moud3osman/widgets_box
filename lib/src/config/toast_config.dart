import 'package:flutter/material.dart';

/// Styling defaults for the smart toast, resolved through
/// [WidgetsBoxConfigProvider]. Null fields fall back to the toast's built-in
/// defaults, so existing call sites keep their current appearance.
@immutable
class ToastConfig {
  /// Background color for success toasts.
  final Color? successColor;

  /// Background color for error toasts.
  final Color? errorColor;

  /// Text style for the toast message.
  final TextStyle? textStyle;

  /// Corner radius of the toast container.
  final double? radius;

  /// How long the toast stays on screen before auto-dismissing.
  final Duration? duration;

  /// Maximum number of message lines before truncating.
  final int? maxLines;

  const ToastConfig({
    this.successColor,
    this.errorColor,
    this.textStyle,
    this.radius,
    this.duration,
    this.maxLines,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToastConfig &&
          runtimeType == other.runtimeType &&
          successColor == other.successColor &&
          errorColor == other.errorColor &&
          textStyle == other.textStyle &&
          radius == other.radius &&
          duration == other.duration &&
          maxLines == other.maxLines;

  @override
  int get hashCode =>
      Object.hash(successColor, errorColor, textStyle, radius, duration, maxLines);
}
