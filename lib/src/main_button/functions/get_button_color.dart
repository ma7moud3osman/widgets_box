import 'package:flutter/material.dart';

import '../widgets/main_button.dart';

/// Button color resolvers.
///
/// Colors derive from the app's [ColorScheme] (the modern source that
/// `ThemeData.primaryColor` mirrors) so buttons follow the application theme
/// instead of hard-coded `Colors.white`/`primaryColor`. An explicit [color]
/// always wins, letting callers override per instance.
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
        return theme.colorScheme.primary;
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
  final scheme = Theme.of(context).colorScheme;
  return _resolve(color, () {
    switch (type) {
      case WBButtonType.primary:
      case WBButtonType.secondary:
        return scheme.primary;
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
  final scheme = Theme.of(context).colorScheme;
  return _resolve(color, () {
    switch (type) {
      case WBButtonType.primary:
        return scheme.onPrimary;
      case WBButtonType.secondary:
      case WBButtonType.tertiary:
        return scheme.primary;
    }
  });
}

Color getLoadingColor(
  WBButtonType type,
  BuildContext context, {
  required Color? color,
}) =>
    getTextColor(type, context, color: color);
