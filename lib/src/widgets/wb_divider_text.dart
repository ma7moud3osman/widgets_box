import 'package:flutter/material.dart';

/// A horizontal divider with a centered label — the "──── OR ────" separator
/// every app hand-rolls between form sections and auth options.
class WBDividerText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? lineColor;
  final double thickness;
  final double spacing;
  final EdgeInsetsGeometry padding;

  const WBDividerText({
    super.key,
    required this.text,
    this.textStyle,
    this.lineColor,
    this.thickness = 1,
    this.spacing = 12,
    this.padding = EdgeInsets.zero,
  });

  /// A pre-filled `OR`-style separator. Pass a localized [text] (e.g.
  /// `'or'.tr()`); defaults to `'OR'`.
  const WBDividerText.or({
    Key? key,
    String text = 'OR',
    TextStyle? textStyle,
    Color? lineColor,
    double thickness = 1,
    double spacing = 12,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) : this(
          key: key,
          text: text,
          textStyle: textStyle,
          lineColor: lineColor,
          thickness: thickness,
          spacing: spacing,
          padding: padding,
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final line = Expanded(
      child: Divider(
        color: lineColor ?? theme.dividerColor,
        thickness: thickness,
      ),
    );
    return Padding(
      padding: padding,
      child: Row(
        children: [
          line,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing),
            child: Text(
              text,
              style: textStyle ??
                  theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
            ),
          ),
          line,
        ],
      ),
    );
  }
}
