import 'package:flutter/material.dart';

/// An inline prompt with a tappable trailing action — the
/// "Don't have an account? Sign up" row every app re-implements.
///
/// [text] is the muted lead-in and [actionText] is the emphasized, tappable
/// portion. Both are caller-provided (already localized).
class WBTextLink extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final TextStyle? actionStyle;
  final Color? actionColor;
  final MainAxisAlignment alignment;
  final double spacing;

  const WBTextLink({
    super.key,
    required this.text,
    required this.actionText,
    this.onTap,
    this.textStyle,
    this.actionStyle,
    this.actionColor,
    this.alignment = MainAxisAlignment.center,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle = textStyle ??
        theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor);
    final linkStyle = actionStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: actionColor ?? theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
        );

    return Row(
      mainAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(text, style: baseStyle)),
        SizedBox(width: spacing),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Text(actionText, style: linkStyle),
        ),
      ],
    );
  }
}
