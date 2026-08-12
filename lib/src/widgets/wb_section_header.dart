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
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  upperCase ? title.toUpperCase() : title,
                  style: titleStyle ??
                      theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
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
