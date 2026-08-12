import 'package:flutter/material.dart';

/// App-wide defaults for [WBCard], resolved through [WidgetsBoxConfigProvider].
///
/// This is the "package defaults" layer of the Theme → config → local-override
/// hierarchy: an app sets its card radius/padding/border once here (mirroring
/// the `AppRadius`/`AppPadding` tokens every app currently copies), individual
/// cards override per-instance, and anything left null falls back to the
/// widget's built-in defaults / the Flutter [Theme]. Null fields never force a
/// value, so existing screens are unaffected until they opt in.
@immutable
class WBCardConfig {
  /// Corner radius. Defaults to 16 when unset.
  final double? radius;

  /// Inner content padding. Defaults to `EdgeInsets.all(16)` when unset.
  final EdgeInsetsGeometry? padding;

  /// Background color. Falls back to `Theme.cardColor` when unset.
  final Color? color;

  /// Border color for the `bordered` style. Falls back to `Theme.dividerColor`.
  final Color? borderColor;

  /// Border stroke width for the `bordered` style. Defaults to 1.
  final double? borderWidth;

  /// Shadow color for the `elevated` style. Falls back to a soft neutral.
  final Color? shadowColor;

  /// Shadow blur radius for the `elevated` style. Defaults to 12.
  final double? elevation;

  const WBCardConfig({
    this.radius,
    this.padding,
    this.color,
    this.borderColor,
    this.borderWidth,
    this.shadowColor,
    this.elevation,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WBCardConfig &&
          runtimeType == other.runtimeType &&
          radius == other.radius &&
          padding == other.padding &&
          color == other.color &&
          borderColor == other.borderColor &&
          borderWidth == other.borderWidth &&
          shadowColor == other.shadowColor &&
          elevation == other.elevation;

  @override
  int get hashCode => Object.hash(
        radius,
        padding,
        color,
        borderColor,
        borderWidth,
        shadowColor,
        elevation,
      );
}
