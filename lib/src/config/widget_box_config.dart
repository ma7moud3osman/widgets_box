import 'package:flutter/material.dart';
import 'package:widgets_box/src/config/text_field_config.dart';

import 'button_config.dart';

class WidgetsBoxConfig {
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final TextFieldConfig? textFieldConfig;
  final ButtonConfig? buttonConfig;

  const WidgetsBoxConfig({
    this.width,
    this.height,
    this.radius,
    this.contentPadding,
    this.textFieldConfig,
    this.buttonConfig,
  });
}
