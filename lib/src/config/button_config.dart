import 'package:flutter/material.dart';

/// Styling defaults for [WBButton] and friends, resolved through
/// [WidgetsBoxConfigProvider]. Every field is optional; a null field falls back
/// to [WidgetsBoxConfig] and then to the widget's built-in default.
@immutable
class ButtonConfig {
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;

  /// Foreground (label/icon) color used while the button is disabled.
  final Color? disableLabelColor;

  const ButtonConfig({
    this.width,
    this.height,
    this.radius,
    this.contentPadding,
    this.disableLabelColor,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ButtonConfig &&
          runtimeType == other.runtimeType &&
          width == other.width &&
          height == other.height &&
          radius == other.radius &&
          contentPadding == other.contentPadding &&
          disableLabelColor == other.disableLabelColor;

  @override
  int get hashCode =>
      Object.hash(width, height, radius, contentPadding, disableLabelColor);
}
