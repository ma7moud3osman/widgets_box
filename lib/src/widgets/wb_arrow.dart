import 'package:flutter/material.dart';

/// A directional chevron that automatically flips for RTL locales — the
/// "forward/back" arrow every app re-implements so it points the right way in
/// Arabic without per-call-site conditionals.
///
/// [forward] (default) points in the reading direction (right in LTR, left in
/// RTL); set it to `false` for a "back" arrow.
class WBArrow extends StatelessWidget {
  final bool forward;
  final double size;
  final Color? color;

  const WBArrow({
    super.key,
    this.forward = true,
    this.size = 18,
    this.color,
  });

  const WBArrow.back({Key? key, double size = 18, Color? color})
      : this(key: key, forward: false, size: size, color: color);

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    // In LTR: forward → right, back → left. Flip both in RTL.
    final pointsRight = forward != isRtl;
    return Icon(
      pointsRight ? Icons.chevron_right : Icons.chevron_left,
      size: size,
      color: color,
    );
  }
}
