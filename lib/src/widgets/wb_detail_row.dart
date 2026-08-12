import 'package:flutter/material.dart';

/// Orientation for [WBDetailRow].
enum WBDetailAxis {
  /// Label and value on one line, pushed to opposite ends.
  horizontal,

  /// Label above, value below.
  vertical,
}

/// A label/value pair — the `SummaryRow` / `DetailRow` / `InfoRow` shape used
/// across detail and summary screens.
///
/// ```dart
/// WBDetailRow(label: 'Status', valueWidget: WBStatusBadge(label: 'Paid'));
/// WBDetailRow(label: 'Phone', value: '+20 100 000 0000', leadingIcon: Icons.phone);
/// WBDetailRow.money(label: 'Total', value: 20000, total: true); // via valueBuilder
/// ```
class WBDetailRow extends StatelessWidget {
  final String label;

  /// Plain text value. Ignored when [valueWidget] is provided.
  final String? value;

  /// A custom value widget (badge, money, link); wins over [value].
  final Widget? valueWidget;

  final IconData? leadingIcon;

  /// Tints the value (e.g. red/green for debit/credit).
  final Color? valueColor;

  /// Bolds both label and value (totals).
  final bool emphasized;

  final WBDetailAxis axis;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const WBDetailRow({
    super.key,
    required this.label,
    this.value,
    this.valueWidget,
    this.leadingIcon,
    this.valueColor,
    this.emphasized = false,
    this.axis = WBDetailAxis.horizontal,
    this.padding,
    this.labelStyle,
    this.valueStyle,
  });

  /// Convenience for money rows: formats [value] with [format] (defaults to a
  /// grouped integer, dropping a trailing `.00`) and bolds it when [total].
  factory WBDetailRow.money({
    Key? key,
    required String label,
    required num value,
    String Function(num value)? format,
    bool total = false,
    Color? valueColor,
    WBDetailAxis axis = WBDetailAxis.horizontal,
    EdgeInsetsGeometry? padding,
  }) {
    final text = (format ?? _defaultMoney)(value);
    return WBDetailRow(
      key: key,
      label: label,
      value: text,
      emphasized: total,
      valueColor: valueColor,
      axis: axis,
      padding: padding,
    );
  }

  static String _defaultMoney(num value) {
    final rounded = value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(2);
    // Group thousands with commas.
    final parts = rounded.split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]},',
    );
    return parts.length > 1 ? '$intPart.${parts[1]}' : intPart;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weight = emphasized ? FontWeight.bold : null;

    final labelWidget = Text(
      label,
      style: labelStyle ??
          theme.textTheme.bodySmall?.copyWith(
            color: emphasized ? null : theme.hintColor,
            fontWeight: weight,
          ),
    );

    final Widget valuePart = valueWidget ??
        Text(
          value ?? '',
          textAlign:
              axis == WBDetailAxis.horizontal ? TextAlign.end : TextAlign.start,
          style: valueStyle ??
              theme.textTheme.bodyMedium?.copyWith(
                color: valueColor,
                fontWeight: weight,
              ),
        );

    final content = axis == WBDetailAxis.horizontal
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: 16, color: theme.hintColor),
                const SizedBox(width: 6),
              ],
              Expanded(child: labelWidget),
              const SizedBox(width: 12),
              Flexible(child: valuePart),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              labelWidget,
              const SizedBox(height: 4),
              valuePart,
            ],
          );

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 6),
      child: content,
    );
  }
}
