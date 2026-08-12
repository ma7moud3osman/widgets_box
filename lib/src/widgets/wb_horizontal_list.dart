import 'package:flutter/material.dart';

/// A fixed-height horizontal list with a built-in empty state — the
/// `HorizontalListWidget` every app re-implements for carousels and chip rows.
class WBHorizontalList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double height;
  final EdgeInsetsGeometry? padding;
  final Widget? separator;
  final Widget? emptyWidget;
  final String? emptyText;
  final ScrollController? controller;
  final ScrollPhysics? physics;

  const WBHorizontalList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.height = 120,
    this.padding,
    this.separator,
    this.emptyWidget,
    this.emptyText,
    this.controller,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      final empty = emptyWidget ??
          (emptyText == null
              ? const SizedBox.shrink()
              : Center(
                  child: Text(
                    emptyText!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Theme.of(context).hintColor),
                  ),
                ));
      return SizedBox(height: height, child: empty);
    }
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        controller: controller,
        physics: physics,
        padding: padding,
        itemCount: items.length,
        separatorBuilder: (_, __) =>
            separator ?? const SizedBox(width: 12),
        itemBuilder: (context, i) => itemBuilder(context, items[i], i),
      ),
    );
  }
}
