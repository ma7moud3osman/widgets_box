import 'package:flutter/material.dart';

/// A form-field label with an optional required asterisk — the
/// `HeaderFieldWidget` every app re-implements above inputs.
class WBFieldLabel extends StatelessWidget {
  final String text;
  final bool isRequired;
  final TextStyle? style;
  final Color? requiredColor;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const WBFieldLabel(
    this.text, {
    super.key,
    this.isRequired = false,
    this.style,
    this.requiredColor,
    this.trailing,
    this.padding = const EdgeInsets.only(bottom: 6),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = style ??
        theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600);
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Flexible(child: Text(text, style: labelStyle)),
          if (isRequired)
            Text(
              ' *',
              style: labelStyle?.copyWith(
                color: requiredColor ?? theme.colorScheme.error,
              ),
            ),
          if (trailing != null) ...[const Spacer(), trailing!],
        ],
      ),
    );
  }
}
