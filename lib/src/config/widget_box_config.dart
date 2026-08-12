import 'package:flutter/material.dart';

import 'button_config.dart';
import 'card_config.dart';
import 'text_field_config.dart';
import 'toast_config.dart';

/// Root configuration for `widgets_box`, provided via
/// [WidgetsBoxConfigProvider]. Widgets resolve each value as
/// `widget property ?? sub-config field ?? top-level field ?? WidgetsBoxConfig.defaults`
/// so there is a single, drift-proof source of truth for the built-in numbers.
@immutable
class WidgetsBoxConfig {
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final TextFieldConfig? textFieldConfig;
  final ButtonConfig? buttonConfig;
  final ToastConfig? toastConfig;
  final WBCardConfig? cardConfig;

  const WidgetsBoxConfig({
    this.width,
    this.height,
    this.radius,
    this.contentPadding,
    this.textFieldConfig,
    this.buttonConfig,
    this.toastConfig,
    this.cardConfig,
  });

  /// The single source of truth for the package's built-in dimensions. Both
  /// [WidgetsBoxConfigProvider.of] and every widget fall back to these, so the
  /// magic numbers never drift apart between call sites.
  static const WidgetsBoxConfig defaults = WidgetsBoxConfig(
    width: 370,
    height: 44,
    radius: 8,
    contentPadding: EdgeInsets.symmetric(horizontal: 8),
    textFieldConfig: TextFieldConfig(cursorHeight: 18.0),
    buttonConfig: ButtonConfig(
      width: 370,
      height: 44,
      radius: 8,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
    ),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WidgetsBoxConfig &&
          runtimeType == other.runtimeType &&
          width == other.width &&
          height == other.height &&
          radius == other.radius &&
          contentPadding == other.contentPadding &&
          textFieldConfig == other.textFieldConfig &&
          buttonConfig == other.buttonConfig &&
          toastConfig == other.toastConfig &&
          cardConfig == other.cardConfig;

  @override
  int get hashCode => Object.hash(
        width,
        height,
        radius,
        contentPadding,
        textFieldConfig,
        buttonConfig,
        toastConfig,
        cardConfig,
      );
}
