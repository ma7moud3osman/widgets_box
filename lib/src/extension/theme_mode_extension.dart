import 'package:flutter/material.dart';

/// Serializes a [ThemeMode] to the stable string every app persists in
/// preferences (`'dark'`, `'light'`, `'system'`).
extension WBThemeModeName on ThemeMode {
  String get toThemeName => switch (this) {
        ThemeMode.dark => 'dark',
        ThemeMode.light => 'light',
        ThemeMode.system => 'system',
      };
}

/// Parses a persisted theme string back to a [ThemeMode], defaulting to
/// [ThemeMode.system] for anything unrecognized.
extension WBThemeModeParse on String? {
  ThemeMode get toThemeMode => switch (this) {
        'dark' => ThemeMode.dark,
        'light' => ThemeMode.light,
        _ => ThemeMode.system,
      };
}
