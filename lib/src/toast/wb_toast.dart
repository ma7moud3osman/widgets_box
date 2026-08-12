import 'package:flutter/material.dart';

import '../config/main_config.dart';
import 'styled_toast.dart';
import 'styled_toast_enum.dart';

/// Semantic kind of a [WBToast].
enum WBToastKind { success, error, info }

/// A theme-aware toast that reads its colors, radius, duration and max-lines
/// from [ToastConfig] (via [WidgetsBoxConfigProvider]) and falls back to the
/// app's [ColorScheme].
///
/// This is the adoption-friendly replacement for the bare `showToastError` /
/// `showToastSuccess` free functions: it lives under the `WBToast` namespace so
/// it never collides with an app's own toast helpers, and it renders through
/// the package's existing overlay engine.
///
/// ```dart
/// WBToast.success(context, 'Saved');
/// WBToast.error(context, 'Could not connect');
/// ```
class WBToast {
  const WBToast._();

  static void success(BuildContext context, String message, {IconData? icon}) =>
      show(context, message, kind: WBToastKind.success, icon: icon);

  static void error(BuildContext context, String message, {IconData? icon}) =>
      show(context, message, kind: WBToastKind.error, icon: icon);

  static void info(BuildContext context, String message, {IconData? icon}) =>
      show(context, message, kind: WBToastKind.info, icon: icon);

  static void show(
    BuildContext context,
    String message, {
    WBToastKind kind = WBToastKind.info,
    IconData? icon,
    Duration? duration,
  }) {
    final config = WidgetsBoxConfigProvider.of(context).toastConfig;
    final scheme = Theme.of(context).colorScheme;

    final background = switch (kind) {
      WBToastKind.success => config?.successColor ?? const Color(0xFF2E7D4F),
      WBToastKind.error => config?.errorColor ?? scheme.error,
      WBToastKind.info => scheme.inverseSurface,
    };
    final foreground = switch (kind) {
      WBToastKind.error => scheme.onError,
      WBToastKind.info => scheme.onInverseSurface,
      WBToastKind.success => Colors.white,
    };
    final glyph = icon ??
        switch (kind) {
          WBToastKind.success => Icons.check_circle,
          WBToastKind.error => Icons.cancel,
          WBToastKind.info => Icons.info,
        };

    final radius = config?.radius ?? 12;
    final maxLines = config?.maxLines ?? 3;
    final dur = duration ?? config?.duration ?? const Duration(seconds: 3);
    // Cap width to the screen (with insets) instead of a fixed 350 that
    // overflows on small devices.
    final maxWidth = MediaQuery.of(context).size.width - 32;

    showToastWidget(
      context: context,
      animation: StyledToastAnimation.fade,
      duration: dur,
      dismissOtherToast: true,
      builder: (_, __) => Padding(
        padding: const EdgeInsets.all(8),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 40, maxWidth: maxWidth),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(glyph, color: foreground, size: 20),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      message,
                      maxLines: maxLines,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: foreground),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
