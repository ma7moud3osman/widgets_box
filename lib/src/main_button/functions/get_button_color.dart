import 'package:flutter/material.dart';

import '../widgets/main_button.dart';

/// Button color resolvers.
///
/// The primary background follows `Theme.primaryColor` (the field apps actually
/// configure for their brand) and primary foreground defaults to white — the
/// historical, high-contrast behavior. An explicit [color] always wins, so a
/// consumer can pass `ColorScheme` values (or anything else) per instance.
///
/// The four resolvers share one shape (explicit override → per-type value), so
/// each delegates to [_resolve] to keep the branching in one place (DRY) while
/// each function keeps a single, clearly-named responsibility (SRP).
Color _resolve(Color? override, Color Function() ifUnset) =>
    override ?? ifUnset();

Color getBackgroundColor(
  WBButtonType type,
  BuildContext context, {
  required Color? color,
}) {
  final theme = Theme.of(context);
  return _resolve(color, () {
    switch (type) {
      case WBButtonType.primary:
        return theme.primaryColor;
      case WBButtonType.secondary:
        return theme.scaffoldBackgroundColor;
      case WBButtonType.tertiary:
        return Colors.transparent;
    }
  });
}

Color getBorderColor(
  WBButtonType type,
  BuildContext context, {
  required Color? color,
}) {
  final theme = Theme.of(context);
  return _resolve(color, () {
    switch (type) {
      case WBButtonType.primary:
      case WBButtonType.secondary:
        return theme.primaryColor;
      case WBButtonType.tertiary:
        return Colors.transparent;
    }
  });
}

Color getTextColor(
  WBButtonType type,
  BuildContext context, {
  required Color? color,
}) {
  final theme = Theme.of(context);
  return _resolve(color, () {
    switch (type) {
      case WBButtonType.primary:
        return Colors.white;
      case WBButtonType.secondary:
      case WBButtonType.tertiary:
        return theme.primaryColor;
    }
  });
}

Color getLoadingColor(
  WBButtonType type,
  BuildContext context, {
  required Color? color,
}) =>
    getTextColor(type, context, color: color);
