import 'package:flutter/material.dart';

import '../widgets/main_button.dart';

// Colors derive from the app's [ColorScheme] (the modern source that
// `ThemeData.primaryColor` mirrors) so buttons follow the application theme
// instead of hard-coded `Colors.white`/`primaryColor`. Callers can still pass
// an explicit color to override per instance.

getBackgroundColor(
  MainButtonEnum mainButtonEnum,
  BuildContext context, {
  required Color? color,
}) {
  if (color != null) return color;
  final scheme = Theme.of(context).colorScheme;
  switch (mainButtonEnum) {
    case MainButtonEnum.primary:
      return scheme.primary;
    case MainButtonEnum.secondary:
      return Theme.of(context).scaffoldBackgroundColor;
    case MainButtonEnum.tertiary:
      return Colors.transparent;
  }
}

getBorderColor(
  MainButtonEnum mainButtonEnum,
  BuildContext context, {
  required Color? color,
}) {
  if (color != null) return color;
  final scheme = Theme.of(context).colorScheme;
  switch (mainButtonEnum) {
    case MainButtonEnum.primary:
      return scheme.primary;
    case MainButtonEnum.secondary:
      return scheme.primary;
    case MainButtonEnum.tertiary:
      return Colors.transparent;
  }
}

getTextColor(
  MainButtonEnum mainButtonEnum,
  BuildContext context, {
  required Color? color,
}) {
  if (color != null) return color;
  final scheme = Theme.of(context).colorScheme;
  switch (mainButtonEnum) {
    case MainButtonEnum.primary:
      return scheme.onPrimary;
    case MainButtonEnum.secondary:
      return scheme.primary;
    case MainButtonEnum.tertiary:
      return scheme.primary;
  }
}

getLoadingColor(
  MainButtonEnum mainButtonEnum,
  BuildContext context, {
  required Color? color,
}) {
  if (color != null) return color;
  final scheme = Theme.of(context).colorScheme;
  switch (mainButtonEnum) {
    case MainButtonEnum.primary:
      return scheme.onPrimary;
    case MainButtonEnum.secondary:
      return scheme.primary;
    case MainButtonEnum.tertiary:
      return scheme.primary;
  }
}
