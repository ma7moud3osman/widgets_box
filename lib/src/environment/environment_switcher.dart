import 'package:flutter/material.dart';

import '../restart/app_restarter.dart';
import 'app_environment.dart';
import 'environment_manager.dart';

/// Debug-only bottom sheet that repoints the app at a different backend without
/// editing code or rebuilding from the terminal.
///
/// Selecting an environment persists the choice, runs the app's
/// [WBEnvironmentConfig.onReinitialize] hook (to rebuild any client cached
/// against the old base URL), then remounts the whole tree via [WBAppRestarter]
/// — an in-process restart that keeps a debug session attached.
///
/// The sheet is fully generic: title/subtitle and per-option labels are passed
/// in already-localized by the host app, so the package needs no translations.
class WBEnvironmentSwitcher {
  const WBEnvironmentSwitcher._();

  /// Opens the switcher. Silently does nothing when switching is disabled
  /// (release builds without opt-in), so it is safe to wire behind any gesture.
  static Future<void> show(
    BuildContext context, {
    String? title,
    String? subtitle,
  }) {
    if (!WBEnvironmentManager.isEnabled) {
      return Future<void>.value();
    }

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => _EnvironmentSheet(
        title: title,
        subtitle: subtitle,
      ),
    );
  }
}

class _EnvironmentSheet extends StatefulWidget {
  final String? title;
  final String? subtitle;

  const _EnvironmentSheet({this.title, this.subtitle});

  @override
  State<_EnvironmentSheet> createState() => _EnvironmentSheetState();
}

class _EnvironmentSheetState extends State<_EnvironmentSheet> {
  bool _switching = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final environments = WBEnvironmentManager.config.environments;
    final current = WBEnvironmentManager.current;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 8,
          bottom: 24 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.title != null) ...[
              Text(
                widget.title!,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
            ],
            if (widget.subtitle != null) ...[
              Text(
                widget.subtitle!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: 20),
            ],
            for (var i = 0; i < environments.length; i++) ...[
              _EnvironmentOptionButton(
                environment: environments[i],
                isSelected: environments[i] == current,
                isBusy: _switching,
                onTap: () => _select(environments[i]),
              ),
              if (i < environments.length - 1) const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _select(WBAppEnvironment environment) async {
    if (_switching) return;

    // Re-selecting the active environment is a no-op — just close.
    if (environment == WBEnvironmentManager.current) {
      Navigator.of(context).maybePop();
      return;
    }

    setState(() => _switching = true);

    final config = WBEnvironmentManager.config;
    await WBEnvironmentManager.select(environment);
    await config.onReinitialize?.call();

    if (mounted) {
      Navigator.of(context).maybePop();
    }

    // Remount the tree so every widget re-resolves against the rebuilt
    // singletons. restartContext resolves the current root context at call
    // time, so it stays valid after the awaits above.
    final restartContext = config.restartContext?.call();
    if (restartContext != null && restartContext.mounted) {
      WBAppRestarter.restart(restartContext);
    }
  }
}

class _EnvironmentOptionButton extends StatelessWidget {
  final WBAppEnvironment environment;
  final bool isSelected;
  final bool isBusy;
  final VoidCallback onTap;

  const _EnvironmentOptionButton({
    required this.environment,
    required this.isSelected,
    required this.isBusy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final onPrimary = theme.colorScheme.onPrimary;
    final foreground = isSelected ? onPrimary : theme.colorScheme.onSurface;

    return Material(
      color: isSelected ? primary : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: isBusy ? null : onTap,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? primary : theme.dividerColor,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(environment.icon, size: 20, color: foreground),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  environment.label,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: foreground,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 8),
                Icon(Icons.check_circle, size: 20, color: onPrimary),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
