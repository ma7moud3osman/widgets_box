import 'package:flutter/material.dart';

import '../extension/context_extension.dart';

class SmartStatusWidget extends StatelessWidget {
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final Widget child;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  const SmartStatusWidget({
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
          child: StatusWidget(
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

class StatusWidget extends StatelessWidget {
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

  const StatusWidget({
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
            : null,
      ),
      alignment: Alignment.center,
      child: icon == null
          ? label
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 14, color: textColor),
                const SizedBox(width: 4),
                Flexible(child: label),
              ],
            ),
    );
  }
}
