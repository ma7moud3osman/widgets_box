import 'package:flutter/foundation.dart';

import 'app_environment.dart';
import 'environment_config.dart';

/// Global, generic holder for the currently active [WBAppEnvironment].
///
/// The host app wires this once at startup with an [WBEnvironmentConfig], points
/// its own `baseUrl` getter at [WBEnvironmentManager.baseUrl], and lets the debug
/// [WBEnvironmentSwitcher] mutate it. All release-safety (debug-only switching,
/// always booting into the default in release) lives here so every consuming
/// app inherits the same guarantees.
class WBEnvironmentManager {
  WBEnvironmentManager._();

  static WBEnvironmentConfig? _config;
  static WBAppEnvironment? _current;

  /// Registers the app's environments and callbacks. Call once, before any
  /// code reads [baseUrl] (i.e. before the first network client is built).
  static void init(WBEnvironmentConfig config) {
    _config = config;
    _current = config.defaultEnvironment;
  }

  /// True only when a config is registered AND switching is permitted
  /// (debug builds, or release when explicitly opted in). UI should hide the
  /// switcher entirely when this is false.
  static bool get isEnabled {
    final config = _config;
    return config != null && (kDebugMode || config.enabledInRelease);
  }

  /// The active config. Throws if [init] was never called.
  static WBEnvironmentConfig get config {
    final config = _config;
    if (config == null) {
      throw StateError(
        'WBEnvironmentManager.init() must be called before use.',
      );
    }
    return config;
  }

  /// The currently selected environment, or the default when uninitialized.
  static WBAppEnvironment get current =>
      _current ?? _config?.defaultEnvironment ?? _fallback;

  /// Convenience passthrough the host app's `baseUrl` getter should delegate to.
  static String get baseUrl => current.baseUrl;

  /// Restores the persisted choice. A no-op (stays on the default) when
  /// switching is disabled, so release builds never honor a saved test domain.
  static void loadPersisted() {
    if (!isEnabled) return;
    final saved = config.read?.call();
    if (saved == null) return;
    _current = config.environments.firstWhere(
      (environment) => environment.name == saved,
      orElse: () => config.defaultEnvironment,
    );
  }

  /// Selects [environment] and persists it. No-op when switching is disabled.
  /// Takes effect on the next remount — see [WBEnvironmentSwitcher].
  static Future<void> select(WBAppEnvironment environment) async {
    if (!isEnabled) return;
    _current = environment;
    await config.persist?.call(environment.name);
  }

  /// Test hook: forget the registered config and selection.
  @visibleForTesting
  static void reset() {
    _config = null;
    _current = null;
  }

  static const WBAppEnvironment _fallback = WBAppEnvironment(
    name: 'production',
    label: 'Production',
    baseUrl: '',
  );
}
