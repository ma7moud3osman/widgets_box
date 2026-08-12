import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A price/amount display with an optional struck-through original price and a
/// currency suffix — the `AmountWidget` / `PriceText` every app re-implements.
///
/// The amount is grouped with thousands separators and trailing `.00` is
/// trimmed by default (override with [format]); pass [oldPrice] to show a
/// discount.
class WBAmountText extends StatelessWidget {
  final num amount;
  final num? oldPrice;
  final String? currency;
  final TextStyle? style;
  final TextStyle? currencyStyle;
  final TextStyle? oldPriceStyle;
  final Color? color;
  final double spacing;

  /// Formats a raw number to its display string. Defaults to grouped digits
  /// with up to two decimals and no trailing `.00`.
  final String Function(num value)? format;

  const WBAmountText({
    super.key,
    required this.amount,
    this.oldPrice,
    this.currency,
    this.style,
    this.currencyStyle,
    this.oldPriceStyle,
    this.color,
    this.spacing = 6,
    this.format,
  });

  static final NumberFormat _grouped = NumberFormat('#,##0.##');

  String _fmt(num value) => (format ?? _grouped.format)(value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final amountStyle = (style ?? theme.textTheme.titleMedium)
        ?.copyWith(color: color, fontWeight: FontWeight.w700);
    final curStyle = currencyStyle ??
        amountStyle?.copyWith(
          fontWeight: FontWeight.w500,
          color: (color ?? amountStyle.color)?.withValues(alpha: 0.7),
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(_fmt(amount), style: amountStyle),
        if (currency != null) ...[
          SizedBox(width: spacing / 2),
          Text(currency!, style: curStyle),
        ],
        if (oldPrice != null) ...[
          SizedBox(width: spacing),
          Text(
            _fmt(oldPrice!),
            style: oldPriceStyle ??
                theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                  decoration: TextDecoration.lineThrough,
                ),
          ),
        ],
      ],
    );
  }
}
