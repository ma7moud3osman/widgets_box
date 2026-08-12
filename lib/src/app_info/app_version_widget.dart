import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

/// Formats the primary version line from the installed [version] and
/// [buildNumber] (e.g. `v1.2.3+45`).
typedef WBVersionLabelBuilder = String Function(
  String version,
  String buildNumber,
);

/// Formats the Shorebird patch caption from the active patch [number]
/// (e.g. `v7`).
typedef WBPatchLabelBuilder = String Function(int number);

/// Displays the installed app version + build number, with the active
/// Shorebird patch number as an optional caption below it.
///
/// The patch line only appears when a Shorebird patch is actually installed
/// (release builds patched via `shorebird patch`). On store builds with no
/// patch, or in debug/simulator where Shorebird is unavailable, only the
/// version line shows.
///
/// Both lines are fully configurable via [versionBuilder]/[patchBuilder] and
/// [style]/[patchStyle], so each project reuses the same widget with its own
/// wording (`v1.2.3+45` vs `version 1.2.3 (45)`) and styling. Results are
/// cached across instances so the async lookups run only once per session.
class WBAppVersion extends StatefulWidget {
  /// Style for the version line. Falls back to a muted `bodySmall`.
  final TextStyle? style;

  /// Style for the patch caption. Falls back to [style].
  final TextStyle? patchStyle;

  final EdgeInsetsGeometry? padding;

  final CrossAxisAlignment crossAxisAlignment;

  /// Builds the version line. Defaults to `v{version}+{build}`.
  final WBVersionLabelBuilder? versionBuilder;

  /// Builds the patch caption. Defaults to `v{patch}`.
  final WBPatchLabelBuilder? patchBuilder;

  const WBAppVersion({
    super.key,
    this.style,
    this.patchStyle,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.versionBuilder,
    this.patchBuilder,
  });

  @override
  State<WBAppVersion> createState() => _AppVersionWidgetState();
}

class _AppVersionWidgetState extends State<WBAppVersion> {
  static final ShorebirdUpdater _updater = ShorebirdUpdater();

  // Cached across instances/rebuilds: the version never changes at runtime and
  // the patch only changes across app launches, so we look them up once.
  static String? _cachedVersion;
  static String? _cachedBuildNumber;
  static int? _cachedPatchNumber;
  static bool _loaded = false;

  bool _ready = _loaded;

  @override
  void initState() {
    super.initState();
    if (!_loaded) {
      _load();
    }
  }

  Future<void> _load() async {
    final info = await PackageInfo.fromPlatform();
    _cachedVersion = info.version;
    _cachedBuildNumber = info.buildNumber;
    _cachedPatchNumber = await _readShorebirdPatch();
    _loaded = true;

    if (mounted) {
      setState(() => _ready = true);
    }
  }

  /// Returns the active Shorebird patch number, or null when running on the
  /// base release (no patch) or when Shorebird is unavailable (debug/simulator).
  Future<int?> _readShorebirdPatch() async {
    if (!_updater.isAvailable) {
      return null;
    }
    try {
      final patch = await _updater.readCurrentPatch();
      return patch?.number;
    } catch (_) {
      return null;
    }
  }

  String _versionLabel() {
    final builder =
        widget.versionBuilder ?? (version, build) => 'v$version+$build';
    return builder(_cachedVersion ?? '', _cachedBuildNumber ?? '');
  }

  String _patchLabel(int number) {
    final builder = widget.patchBuilder ?? (n) => 'v$n';
    return builder(number);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready || _cachedVersion == null) {
      return const SizedBox.shrink();
    }

    final defaultStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).hintColor,
        );
    final style = widget.style ?? defaultStyle;
    final patch = _cachedPatchNumber;

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: [
          Text(_versionLabel(), style: style),
          if (patch != null)
            Text(_patchLabel(patch), style: widget.patchStyle ?? style),
        ],
      ),
    );
  }
}
