import 'dart:math';

import 'package:flutter/material.dart';

class ButtonStyleClass extends ButtonStyle {
  final double width;
  final double maxWidth;
  final double height;
  final double radius;
  final double? opacity;
  final Color labelColor;
  final Color borderColor;
  final Color disableColor;
  final Color background;
  final BuildContext context;
  final bool smallSize;
  final EdgeInsetsGeometry contentPadding;

  /// Foreground color while disabled. Defaults to grey.
  final Color? disableLabelColor;

  /// Border stroke width. Defaults to 0.5.
  final double borderWidth;

  const ButtonStyleClass({
    required this.width,
    required this.maxWidth,
    required this.height,
    required this.radius,
    required this.labelColor,
    required this.borderColor,
    required this.background,
    required this.context,
    required this.disableColor,
    required this.smallSize,
    required this.opacity,
    required this.contentPadding,
    this.disableLabelColor,
    this.borderWidth = 0.5,
  });

  ButtonStyle get apply {
    return ButtonStyle(
      elevation: WidgetStateProperty.all<double?>(0),
      padding: WidgetStateProperty.all(contentPadding),
      minimumSize: WidgetStateProperty.all<Size>(
        Size(smallSize ? 60 : min(width, maxWidth), height),
      ),
      maximumSize: WidgetStateProperty.all<Size>(Size(maxWidth, height)),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) =>
            states.contains(WidgetState.disabled) ? disableColor : background,
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) => states.contains(WidgetState.disabled)
            ? (disableLabelColor ?? Colors.grey)
            : labelColor,
      ),
      side: WidgetStateProperty.resolveWith<BorderSide>(
        (Set<WidgetState> states) => BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}
