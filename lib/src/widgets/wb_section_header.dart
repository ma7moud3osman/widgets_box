import 'package:flutter/material.dart';

/// A section title with an optional action — the `Row(title … see-all)` header
/// several apps ship as a drifting `HeaderWidget`.
///
/// ```dart
/// WBSectionHeader(title: 'Recent orders', actionLabel: 'See all', onAction: ...);
/// WBSectionHeader(title: 'Summary', trailing: MyFilterButton());
/// ```
class WBSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  /// Text for the trailing action (e.g. "See all"). Ignored when [trailing] is
  /// provided.
  final String? actionLabel;

  /// Called when the action text is tapped.
  final VoidCallback? onAction;

  /// A custom trailing widget; wins over [actionLabel].
  final Widget? trailing;

  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  /// Uppercases the title (some apps render section titles in caps).
  final bool upperCase;

  final EdgeInsetsGeometry? padding;

  /// Optional leading widget before the title (e.g. an accent bar or icon).
  final Widget? leading;

  /// Appends a red required asterisk after the title.
  final bool isRequired;

  /// A small widget shown immediately after the title (e.g. a count badge).
  final Widget? titleBadge;

  /// Color of the [actionLabel] text. Defaults to the theme primary.
  final Color? actionColor;

  const WBSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.trailing,
    this.titleStyle,
    this.subtitleStyle,
    this.upperCase = false,
    this.padding,
    this.leading,
    this.isRequired = false,
    this.titleBadge,
    this.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget? action = trailing;
    if (action == null && actionLabel != null) {
      action = InkWell(
        onTap: onAction,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            actionLabel!,
            style: theme.textTheme.labelLarge?.copyWith(
              color: actionColor ?? theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    final titleText = Text(
      upperCase ? title.toUpperCase() : title,
      style: titleStyle ??
          theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
    final Widget titleLine = (isRequired || titleBadge != null)
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: titleText),
              if (isRequired)
                Text(
                  ' *',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (titleBadge != null) ...[
                const SizedBox(width: 8),
                titleBadge!,
              ],
            ],
          )
        : titleText;

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                titleLine,
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: subtitleStyle ??
                        theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action,
        ],
      ),
    );
  }
}
