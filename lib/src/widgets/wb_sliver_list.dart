import 'package:flutter/material.dart';

/// A lazy sliver list with a built-in empty state — the `VerticalSliverListWidget`
/// every app re-implements. Returns a **sliver**, so place it directly in a
/// `CustomScrollView`'s `slivers` (compose a header/app-bar sliver alongside it).
class WBSliverList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? separator;
  final Widget? emptyWidget;
  final String? emptyText;

  const WBSliverList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.separator,
    this.emptyWidget,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      final empty = emptyWidget ??
          (emptyText == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      emptyText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Theme.of(context).hintColor),
                    ),
                  ),
                ));
      return SliverToBoxAdapter(child: empty);
    }

    if (separator != null) {
      return SliverList.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => separator!,
        itemBuilder: (context, i) => itemBuilder(context, items[i], i),
      );
    }
    return SliverList.builder(
      itemCount: items.length,
      itemBuilder: (context, i) => itemBuilder(context, items[i], i),
    );
  }
}
