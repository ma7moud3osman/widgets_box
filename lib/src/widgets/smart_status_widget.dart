import 'package:flutter/material.dart';
import 'package:widgets_box/widgets_box.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? textColor?.withValues(alpha: 0.05),
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style:
            style?.copyWith(color: textColor) ??
            context.bodySmall?.copyWith(color: textColor),
      ),
    );
  }
}
