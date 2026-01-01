import 'package:flutter/material.dart';

class SmartTagWidget extends StatelessWidget {
  final String? text;
  final Widget? child;
  final TextStyle? style;
  final Color? backgroundColor;
  final Color? textColor;

  const SmartTagWidget({
    super.key,
    this.text,
    this.style,
    this.backgroundColor,
    this.textColor,
    this.child,
  }) : assert(text != null || child != null);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child:
          child ??
          Text(
            text!,
            style:
                style ??
                Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: textColor ?? Theme.of(context).primaryColor,
                ),
          ),
    );
  }
}
