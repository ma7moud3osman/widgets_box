import 'dart:ui';

import 'package:flutter/material.dart';

class HexColor extends Color {
  /// Convert a Color object to hex color string .
  static String toHexString(Color value) =>
      value.toARGB32().toRadixString(16).padLeft(8, '0');

  /// Convert a hex color string to a Color object.
  static int _getColorFromHex(String? hexColor) {
    if (hexColor == null) return 0xFFFFFFFF;
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String? hexColor) : super(_getColorFromHex(hexColor));
}
