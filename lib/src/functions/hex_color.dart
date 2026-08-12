import 'dart:ui';

import 'package:flutter/material.dart';

class HexColor extends Color {
  /// Convert a Color object to hex color string .
  static String toHexString(Color value) =>
      value.toARGB32().toRadixString(16).padLeft(8, '0');

  /// Convert a hex color string to a Color object. Falls back to opaque white
  /// (`0xFFFFFFFF`) for null, empty, or malformed input instead of throwing.
  /// Supports `#RGB`, `#RRGGBB`, and `#AARRGGBB`, with or without the leading
  /// `#`.
  static int _getColorFromHex(String? hexColor) {
    if (hexColor == null) return 0xFFFFFFFF;
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    // Expand 3-digit shorthand (e.g. F0A -> FF00AA).
    if (hexColor.length == 3) {
      hexColor = hexColor.split('').map((char) => '$char$char').join();
    }
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    // After normalization a valid color is exactly 8 hex chars (AARRGGBB).
    // Any other length is malformed → safe opaque-white fallback.
    if (hexColor.length != 8) return 0xFFFFFFFF;
    return int.tryParse(hexColor, radix: 16) ?? 0xFFFFFFFF;
  }

  HexColor(final String? hexColor) : super(_getColorFromHex(hexColor));
}
