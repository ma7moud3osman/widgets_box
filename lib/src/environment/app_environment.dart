import 'package:flutter/material.dart';

/// One selectable backend target for the debug [WBEnvironmentSwitcher].
///
/// This model is intentionally app-agnostic: the consuming app owns the list of
/// environments and their URLs, so `widgets_box` never hardcodes a domain. The
/// [label] is already-localized display text supplied by the app — the package
/// does not translate it, keeping the switcher free of any localization
/// dependency.
@immutable
class WBAppEnvironment {
  /// Stable identifier persisted to storage (e.g. `production`, `test`).
  /// Must be unique within the configured list and never localized.
  final String name;

  /// Human-readable, already-translated label shown on the option button.
  final String label;

  /// Base URL this environment points the app at (e.g. `https://api.acme.com`).
  final String baseUrl;

  /// Optional icon shown beside the label. Defaults to a neutral cloud glyph.
  final IconData icon;

  const WBAppEnvironment({
    required this.name,
    required this.label,
    required this.baseUrl,
    this.icon = Icons.cloud_outlined,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WBAppEnvironment &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          baseUrl == other.baseUrl;

  @override
  int get hashCode => Object.hash(name, baseUrl);

  @override
  String toString() => 'WBAppEnvironment($name, $baseUrl)';
}
