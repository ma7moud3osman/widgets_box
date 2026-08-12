import 'package:flutter/widgets.dart';

import 'app_environment.dart';

/// Persists the developer's chosen environment name. Return `null` from [read]
/// when nothing has been saved yet.
typedef WBEnvironmentPersistCallback = Future<void> Function(String name);
typedef WBEnvironmentReadCallback = String? Function();

/// App-supplied hook that rebuilds anything cached against the old base URL
/// (e.g. a GetIt service locator: `await sl.reset(); await initDependencies();`).
/// Runs after the new environment is persisted and before the app is remounted.
typedef WBEnvironmentReinitializeCallback = Future<void> Function();

/// Everything the generic [WBEnvironmentSwitcher] needs from the host app,
/// gathered in one place so `widgets_box` stays free of app-specific globals.
///
/// The switcher is a DEBUG tool. By default it is inert in release builds
/// ([enabledInRelease] = false) so a shipped build can never boot into anything
/// but [defaultEnvironment], regardless of what is persisted on a device.
@immutable
class WBEnvironmentConfig {
  /// Selectable targets, in display order. Must be non-empty.
  final List<WBAppEnvironment> environments;

  /// The environment used before any choice is restored, and the only one a
  /// release build is ever allowed to run.
  final WBAppEnvironment defaultEnvironment;

  /// Persists the chosen environment name. When null, the choice is not
  /// remembered across launches.
  final WBEnvironmentPersistCallback? persist;

  /// Reads the previously persisted environment name. When null, nothing is
  /// restored and [defaultEnvironment] is always used at boot.
  final WBEnvironmentReadCallback? read;

  /// Rebuilds app-level singletons against the newly selected base URL.
  final WBEnvironmentReinitializeCallback? onReinitialize;

  /// Resolves the root [BuildContext] (under an `WBAppRestarter`) used to remount
  /// the tree after switching. Called at switch time, so a getter that returns
  /// the *current* root navigator context is safe here.
  final BuildContext Function()? restartContext;

  /// When true, the switcher also works in release builds. Keep false unless
  /// you deliberately ship an in-app environment picker.
  final bool enabledInRelease;

  const WBEnvironmentConfig({
    required this.environments,
    required this.defaultEnvironment,
    this.persist,
    this.read,
    this.onReinitialize,
    this.restartContext,
    this.enabledInRelease = false,
  }) : assert(environments.length > 0, 'Provide at least one environment');
}
