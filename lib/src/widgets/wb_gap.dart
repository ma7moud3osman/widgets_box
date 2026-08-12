import 'package:flutter/material.dart';

/// A named-size spacer — the `VerticalSpacer`/`HorizontalSpacer` + `AppSpacer`
/// constants combo every app re-implements. Use the axis constructors with an
/// explicit size, or the t-shirt presets (vertical, the common case in
/// `Column`s).
///
/// ```dart
/// Column(children: [A(), const WBGap.md(), B()]);
/// Row(children: [X(), WBGap.horizontal(12), Y()]);
/// ```
class WBGap extends StatelessWidget {
  final double size;
  final Axis axis;

  const WBGap.vertical(this.size, {super.key}) : axis = Axis.vertical;
  const WBGap.horizontal(this.size, {super.key}) : axis = Axis.horizontal;

  const WBGap.xs({super.key})
      : size = 4,
        axis = Axis.vertical;
  const WBGap.sm({super.key})
      : size = 8,
        axis = Axis.vertical;
  const WBGap.md({super.key})
      : size = 12,
        axis = Axis.vertical;
  const WBGap.lg({super.key})
      : size = 16,
        axis = Axis.vertical;
  const WBGap.xl({super.key})
      : size = 24,
        axis = Axis.vertical;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: axis == Axis.horizontal ? size : null,
        height: axis == Axis.vertical ? size : null,
      );
}
