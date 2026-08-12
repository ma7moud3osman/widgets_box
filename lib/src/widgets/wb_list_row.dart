import 'package:flutter/material.dart';

/// A tappable content row — the `InkWell → Row(leading, title/subtitle,
/// trailing)` shape every app re-implements for settings, menus, pickers and
/// info rows. Use the named helpers for the common shapes.
///
/// ```dart
/// WBListRow.menu(leading: Icon(Icons.person), title: 'Profile', onTap: ...);
/// WBListRow.toggle(title: 'Notifications', value: on, onChanged: ...);
/// WBListRow.picker(label: 'Warehouse', value: name, onTap: ...);
/// ```
class WBListRow extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  /// Renders the title/subtitle in the theme's error color for destructive
  /// actions (e.g. "Delete account", "Log out").
  final bool destructive;

  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const WBListRow({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding,
    this.destructive = false,
    this.titleStyle,
    this.subtitleStyle,
  });

  /// A navigation row with an auto, RTL-aware chevron as the trailing widget.
  factory WBListRow.menu({
    Key? key,
    Widget? leading,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    EdgeInsetsGeometry? padding,
    bool destructive = false,
    Widget? trailing,
  }) {
    return WBListRow(
      key: key,
      leading: leading,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      padding: padding,
      destructive: destructive,
      trailing: trailing ?? const _Chevron(),
    );
  }

  /// A row with a trailing switch.
  factory WBListRow.toggle({
    Key? key,
    Widget? leading,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    EdgeInsetsGeometry? padding,
  }) {
    return WBListRow(
      key: key,
      leading: leading,
      title: title,
      subtitle: subtitle,
      padding: padding,
      onTap: () => onChanged(!value),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }

  /// A picker row: [label] as the title with the current [value] + a drop
  /// chevron on the trailing side.
  factory WBListRow.picker({
    Key? key,
    Widget? leading,
    required String label,
    String? value,
    VoidCallback? onTap,
    EdgeInsetsGeometry? padding,
  }) {
    return WBListRow(
      key: key,
      leading: leading,
      title: label,
      onTap: onTap,
      padding: padding,
      trailing: _PickerValue(value: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleColor = destructive ? theme.colorScheme.error : null;

    final row = Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: (titleStyle ?? theme.textTheme.titleMedium)?.copyWith(
                    color: titleColor,
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
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],
        ],
      ),
    );

    if (onTap == null) return row;
    return InkWell(onTap: onTap, child: row);
  }
}

/// A directional chevron that points toward the reading edge (right in LTR,
/// left in RTL).
class _Chevron extends StatelessWidget {
  const _Chevron();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Directionality.of(context) == TextDirection.rtl
          ? Icons.chevron_left
          : Icons.chevron_right,
      color: Theme.of(context).hintColor,
    );
  }
}

class _PickerValue extends StatelessWidget {
  final String? value;
  const _PickerValue({this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value != null)
          Flexible(
            child: Text(
              value!,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),
          ),
        Icon(Icons.keyboard_arrow_down, color: theme.hintColor),
      ],
    );
  }
}
