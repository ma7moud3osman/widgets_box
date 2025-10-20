import 'package:flutter/material.dart';

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
  });
}
