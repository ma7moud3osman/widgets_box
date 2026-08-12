import 'package:flutter/material.dart';

/// An animated page indicator — the row of dots (with a stretched active dot)
/// every app hand-rolls for onboarding and carousels.
class WBPageDots extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color? activeColor;
  final Color? color;
  final double dotSize;
  final double activeWidth;
  final double spacing;
  final Duration duration;

  const WBPageDots({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.color,
    this.dotSize = 8,
    this.activeWidth = 22,
    this.spacing = 6,
    this.duration = const Duration(milliseconds: 250),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor ?? theme.colorScheme.primary;
    final inactive = color ?? theme.disabledColor.withValues(alpha: 0.4);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final selected = i == currentIndex;
        return AnimatedContainer(
          duration: duration,
          curve: Curves.easeOut,
          width: selected ? activeWidth : dotSize,
          height: dotSize,
          margin: EdgeInsets.only(right: i == count - 1 ? 0 : spacing),
          decoration: BoxDecoration(
            color: selected ? active : inactive,
            borderRadius: BorderRadius.circular(dotSize),
          ),
        );
      }),
    );
  }
}
