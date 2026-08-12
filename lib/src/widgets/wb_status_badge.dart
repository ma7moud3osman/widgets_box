import 'package:flutter/material.dart';

import '../functions/hex_color.dart';
import 'smart_status_widget.dart';

/// A status pill driven by a backend-supplied color, folding the
/// `ClientStatusBadge` / `RepStockBadge` patterns the apps hand-roll on top of
/// [WBStatus].
///
/// The color is resolved, in order, from an explicit [color], then a
/// [colorValue] string that may be a hex code (`#2E7D4F`, `2e7d4f`) or a
/// semantic/Filament name (`success`, `danger`, `warning`, `info`, `primary`,
/// `gray`), then the theme primary. Pass [hideWhenEmpty] to collapse the badge
/// when there is nothing to show (e.g. a healthy stock row).
///
/// ```dart
/// WBStatusBadge(label: order.statusLabel, colorValue: order.statusColor);
/// WBStatusBadge(label: 'Overdue', colorValue: 'danger', icon: Icons.warning);
/// ```
class WBStatusBadge extends StatelessWidget {
  final String label;

  /// A hex code or semantic/Filament color name. Ignored when [color] is set.
  final String? colorValue;

  /// Explicit color override; wins over [colorValue].
  final Color? color;

  final IconData? icon;

  /// Outlined pill instead of the translucent fill.
  final bool outlined;

  /// When true and [label] is empty, renders nothing.
  final bool hideWhenEmpty;

  /// Shows a filled fill AND a same-hue border together (a common chip look).
  final bool showBorder;

  /// Shows a small leading status dot in the resolved color.
  final bool leadingDot;

  final double? height;
  final double radius;

  /// Custom (possibly asymmetric) corner radius; wins over [radius].
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  /// Makes the whole badge tappable (e.g. opens a details sheet).
  final VoidCallback? onTap;

  /// Fill opacity applied to the resolved color for the translucent background.
  final double fillOpacity;

  const WBStatusBadge({
    super.key,
    required this.label,
    this.colorValue,
    this.color,
    this.icon,
    this.outlined = false,
    this.hideWhenEmpty = false,
    this.showBorder = false,
    this.leadingDot = false,
    this.height,
    this.radius = 8,
    this.borderRadius,
    this.style,
    this.padding,
    this.onTap,
    this.fillOpacity = 0.12,
  });

  @override
  Widget build(BuildContext context) {
    if (hideWhenEmpty && label.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    final resolved = color ?? resolveStatusColor(context, colorValue);
    Widget badge = WBStatus(
      text: label,
      height: height ?? 26,
      radius: radius,
      borderRadius: borderRadius,
      textColor: resolved,
      backgroundColor: outlined ? null : resolved.withValues(alpha: fillOpacity),
      outlined: outlined,
      borderColor: showBorder ? resolved : null,
      leadingDot: leadingDot,
      icon: icon,
      style: style,
      padding: padding,
    );
    if (onTap != null) {
      badge = GestureDetector(onTap: onTap, child: badge);
    }
    return badge;
  }

  /// Resolves a backend color string to a [Color]. Falls back to the theme
  /// primary for null/unknown values.
  static Color resolveStatusColor(BuildContext context, String? value) {
    final scheme = Theme.of(context).colorScheme;
    if (value == null || value.trim().isEmpty) return scheme.primary;
    final normalized = value.trim().toLowerCase();

    switch (normalized) {
      case 'success':
      case 'green':
      case 'paid':
      case 'active':
      case 'approved':
        return const Color(0xFF2E7D4F);
      case 'danger':
      case 'error':
      case 'red':
      case 'rejected':
      case 'failed':
        return scheme.error;
      case 'warning':
      case 'orange':
      case 'amber':
      case 'pending':
        return const Color(0xFFC06A12);
      case 'info':
      case 'blue':
        return const Color(0xFF2C6EA6);
      case 'primary':
        return scheme.primary;
      case 'secondary':
        return scheme.secondary;
      case 'gray':
      case 'grey':
      case 'default':
        return const Color(0xFF5C6675);
    }

    // Not a known name — treat it as a hex code (HexColor is crash-safe and
    // returns opaque white for anything unparseable).
    return HexColor(value);
  }
}
