import 'package:flutter/material.dart';

/// Styling defaults for the text-field family, resolved through
/// [WidgetsBoxConfigProvider]. Null fields fall back to [WidgetsBoxConfig] and
/// then to the widget's built-in default.
@immutable
class TextFieldConfig {
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final double? cursorHeight;
  final Color? iconColor;
  final double? iconPadding;
  final double? iconSize;
  final bool? showIcon;

  /// Fill color applied when a field is `filled`.
  final Color? fillColor;

  /// Border color for the enabled (unfocused) state.
  final Color? borderColor;

  /// Border color for the focused state. Falls back to the theme primary.
  final Color? focusedBorderColor;

  /// Border stroke width. Defaults to 1.0 when a border color is set.
  final double? borderWidth;

  /// Color for the floating/label text. Falls back to the theme.
  final Color? labelColor;

  const TextFieldConfig({
    this.width,
    this.height,
    this.radius,
    this.contentPadding,
    this.cursorHeight,
    this.iconColor,
    this.iconPadding,
    this.iconSize,
    this.showIcon,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderWidth,
    this.labelColor,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextFieldConfig &&
          runtimeType == other.runtimeType &&
          width == other.width &&
          height == other.height &&
          radius == other.radius &&
          contentPadding == other.contentPadding &&
          cursorHeight == other.cursorHeight &&
          iconColor == other.iconColor &&
          iconPadding == other.iconPadding &&
          iconSize == other.iconSize &&
          showIcon == other.showIcon &&
          fillColor == other.fillColor &&
          borderColor == other.borderColor &&
          focusedBorderColor == other.focusedBorderColor &&
          borderWidth == other.borderWidth &&
          labelColor == other.labelColor;

  @override
  int get hashCode => Object.hashAll([
        width,
        height,
        radius,
        contentPadding,
        cursorHeight,
        iconColor,
        iconPadding,
        iconSize,
        showIcon,
        fillColor,
        borderColor,
        focusedBorderColor,
        borderWidth,
        labelColor,
      ]);
}
