import 'package:flutter/material.dart';

import '../extension/context_extension.dart';

class WBPositionedStatus extends StatelessWidget {
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final Widget child;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const WBPositionedStatus({
    super.key,
    this.height = 26,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    required this.text,
    required this.child,
    this.style,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        child,
        PositionedDirectional(
          end: 0,
          height: height,
          child: WBStatus(
            height: height,
            borderRadius: borderRadius,
            backgroundColor: backgroundColor,
            textColor: textColor,
            text: text,
            style: style,
            padding: padding,
          ),
        ),
      ],
    );
  }
}

class WBStatus extends StatelessWidget {
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final double radius;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  /// Optional leading icon, tinted to match the label color.
  final IconData? icon;

  /// When true, renders as an outlined pill (transparent fill + colored
  /// border) instead of the filled/translucent default.
  final bool outlined;

  /// Draws a border in this color IN ADDITION to the fill (some chips use a
  /// translucent fill plus a stronger same-hue border). Ignored when [outlined]
  /// is true (which draws its own border).
  final Color? borderColor;

  /// Shows a small filled dot (in [textColor]) before the label.
  final bool leadingDot;

  const WBStatus({
    super.key,
    required this.text,
    this.height = 26,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.radius = 12,
    this.style,
    this.padding,
    this.icon,
    this.outlined = false,
    this.borderColor,
    this.leadingDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedRadius =
        borderRadius ?? BorderRadius.all(Radius.circular(radius));
    final label = Text(
      text,
      overflow: TextOverflow.ellipsis,
      style:
          style?.copyWith(color: textColor) ??
          context.bodySmall?.copyWith(color: textColor),
    );

    return Container(
      height: height,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: outlined
            ? Colors.transparent
            : (backgroundColor ?? textColor?.withValues(alpha: 0.05)),
        borderRadius: resolvedRadius,
        border: outlined
            ? Border.all(
                color: textColor ?? Theme.of(context).colorScheme.outline,
              )
            : (borderColor != null ? Border.all(color: borderColor!) : null),
      ),
      alignment: Alignment.center,
      child: (icon == null && !leadingDot)
          ? label
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingDot)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: textColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                if (icon != null) ...[
                  Icon(icon, size: 14, color: textColor),
                  const SizedBox(width: 4),
                ],
                Flexible(child: label),
              ],
            ),
    );
  }
}
