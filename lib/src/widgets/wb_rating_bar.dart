import 'package:flutter/material.dart';

/// A star rating row — read-only by default, interactive when [onRatingUpdate]
/// is provided. Implemented with Material star icons so it needs no extra
/// dependency, folding the `RatingWidget` / `RatingBarWidget` every app ships.
class WBRatingBar extends StatelessWidget {
  final double rating;
  final int count;
  final double size;
  final Color? color;
  final Color? unratedColor;
  final double spacing;

  /// Renders half stars for fractional ratings (read-only only).
  final bool allowHalf;

  /// When set, the bar becomes tappable and reports the picked value (1…count).
  final ValueChanged<double>? onRatingUpdate;

  const WBRatingBar({
    super.key,
    required this.rating,
    this.count = 5,
    this.size = 20,
    this.color,
    this.unratedColor,
    this.spacing = 2,
    this.allowHalf = true,
    this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final active = color ?? const Color(0xFFF5A623);
    final inactive = unratedColor ?? Theme.of(context).disabledColor;
    final interactive = onRatingUpdate != null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final position = i + 1;
        final IconData glyph;
        if (rating >= position) {
          glyph = Icons.star_rounded;
        } else if (allowHalf && !interactive && rating > position - 1) {
          glyph = Icons.star_half_rounded;
        } else {
          glyph = Icons.star_outline_rounded;
        }
        final star = Padding(
          padding: EdgeInsets.only(right: i == count - 1 ? 0 : spacing),
          child: Icon(
            glyph,
            size: size,
            color: rating >= position - (allowHalf ? 0.5 : 0) ? active : inactive,
          ),
        );
        if (!interactive) return star;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onRatingUpdate!(position.toDouble()),
          child: star,
        );
      }),
    );
  }
}
