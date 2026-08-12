import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_localize/smart_localize.dart';

/// A namespaced facade over the platform-aware dialogs every app hand-rolls —
/// a Cupertino alert on iOS/macOS and a Material dialog everywhere else — with
/// localized default button labels (via `smart_localize`).
abstract final class WBDialogs {
  static bool _isApple(BuildContext context) {
    final platform = Theme.of(context).platform;
    return platform == TargetPlatform.iOS ||
        platform == TargetPlatform.macOS;
  }

  /// Asks the user to confirm an action and resolves to `true` when they accept.
  ///
  /// Set [isDestructive] to style the confirm action as dangerous. Labels
  /// default to the localized `confirm` / `close` strings; override per call.
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    String? message,
    String? confirmLabel,
    String? cancelLabel,
    bool isDestructive = false,
    bool barrierDismissible = true,
  }) async {
    final confirmText = confirmLabel ?? SmartLocalize.confirm;
    final cancelText = cancelLabel ?? SmartLocalize.close;
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        final content = message == null ? null : Text(message);
        if (_isApple(context)) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: content,
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(cancelText),
              ),
              CupertinoDialogAction(
                isDestructiveAction: isDestructive,
                isDefaultAction: !isDestructive,
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(confirmText),
              ),
            ],
          );
        }
        final scheme = Theme.of(context).colorScheme;
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: isDestructive ? scheme.error : scheme.primary,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  /// Shows a single-action informational alert.
  static Future<void> alert(
    BuildContext context, {
    required String title,
    String? message,
    String? buttonLabel,
  }) {
    final okText = buttonLabel ?? SmartLocalize.ok;
    return showDialog<void>(
      context: context,
      builder: (context) {
        final content = message == null ? null : Text(message);
        if (_isApple(context)) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: content,
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.of(context).pop(),
                child: Text(okText),
              ),
            ],
          );
        }
        return AlertDialog(
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(okText),
            ),
          ],
        );
      },
    );
  }
}
