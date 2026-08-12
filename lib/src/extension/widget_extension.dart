import 'package:flutter/material.dart';

/// Convenience wrappers every app re-implements for composing a [Widget] into
/// a scroll/visibility tree without an extra nesting level at the call site.
extension WBWidgetExtension on Widget {
  /// Wraps this widget in a [SliverToBoxAdapter] so a box widget can sit inside
  /// a `CustomScrollView` alongside real slivers.
  Widget get toSliver => SliverToBoxAdapter(child: this);

  /// Wraps this widget in [Padding].
  Widget withPadding(EdgeInsetsGeometry padding) =>
      Padding(padding: padding, child: this);

  /// Centers this widget.
  Widget get centered => Center(child: this);

  /// Makes this widget [Flexible] with the given [flex] and [fit].
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// Makes this widget [Expanded] with the given [flex].
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Shows or fully removes this widget based on [visible] (keeps `const`
  /// call sites tidy instead of a ternary returning `SizedBox.shrink`).
  Widget visible(bool visible) => visible ? this : const SizedBox.shrink();
}
