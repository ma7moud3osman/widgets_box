import 'package:flutter/material.dart';

/// A namespaced facade over `showModalBottomSheet`, folding the bottom-sheet
/// scaffold every app hand-rolls (rounded top, drag handle, optional
/// title/subtitle header, keyboard-aware padding) into one call.
///
/// ```dart
/// WBSheets.show(
///   context,
///   title: 'log_out'.tr(),
///   subtitle: 'log_out_body'.tr(),
///   builder: (context) => const LogoutActions(),
/// );
/// ```
abstract final class WBSheets {
  /// Presents [builder] in a themed modal bottom sheet and resolves with the
  /// value the sheet is popped with.
  ///
  /// The sheet sizes to its content by default and grows up to the full height
  /// when [isScrollControlled] is true. Title/subtitle are caller-provided (and
  /// therefore already localized); pass [showHandle] `false` to drop the drag
  /// indicator.
  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    String? title,
    String? subtitle,
    bool showHandle = true,
    bool isDismissible = true,
    bool isScrollControlled = true,
    bool useSafeArea = true,
    Color? backgroundColor,
    double radius = 20,
    EdgeInsetsGeometry padding =
        const EdgeInsets.fromLTRB(16, 8, 16, 16),
  }) {
    final theme = Theme.of(context);
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      ),
      builder: (context) {
        // Add the keyboard inset so fields inside the sheet stay visible.
        final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Padding(
            padding: padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showHandle)
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12, top: 4),
                      decoration: BoxDecoration(
                        color: theme.dividerColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                if (title != null)
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.hintColor),
                  ),
                ],
                if (title != null || subtitle != null)
                  const SizedBox(height: 16),
                Flexible(child: builder(context)),
              ],
            ),
          ),
        );
      },
    );
  }
}
