import 'package:flutter/widgets.dart';

/// A lightweight, dependency-free replacement for `flutter_phoenix`.
///
/// Wrap the root of your widget tree in an [WBAppRestarter] and call
/// [WBAppRestarter.restart] from anywhere below it to remount the entire subtree
/// in-process — every [State] below is disposed and rebuilt from scratch,
/// exactly as if the app had cold-started, but WITHOUT calling `exit(0)`. This
/// keeps an attached debug session connected and is the mechanism the
/// environment switcher uses to rebuild singletons against a new API domain.
///
/// ```dart
/// runApp(WBAppRestarter(child: const MyApp()));
/// // ...later, after swapping configuration:
/// WBAppRestarter.restart(context);
/// ```
///
/// The remount is achieved by swapping the [Key] of an inner [KeyedSubtree]:
/// changing a child's key forces Flutter to tear down the old element tree and
/// inflate a fresh one, so no state survives across the call.
class WBAppRestarter extends StatefulWidget {
  /// The subtree that is torn down and rebuilt when [restart] is called.
  final Widget child;

  const WBAppRestarter({super.key, required this.child});

  @override
  State<WBAppRestarter> createState() => _AppRestarterState();

  /// Remounts the nearest ancestor [WBAppRestarter] above [context].
  ///
  /// Throws a [FlutterError] in debug mode when no [WBAppRestarter] is found so
  /// the misconfiguration surfaces immediately instead of silently no-opping.
  static void restart(BuildContext context) {
    final state = context.findAncestorStateOfType<_AppRestarterState>();
    assert(() {
      if (state == null) {
        throw FlutterError(
          'WBAppRestarter.restart() was called with a context that does not '
          'have an WBAppRestarter ancestor.\n'
          'Wrap your app (e.g. the widget passed to runApp) in an '
          'WBAppRestarter so restart() has a subtree to remount.',
        );
      }
      return true;
    }());
    state?.restart();
  }
}

class _AppRestarterState extends State<WBAppRestarter> {
  Key _key = UniqueKey();

  void restart() {
    if (!mounted) return;
    setState(() => _key = UniqueKey());
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: widget.child);
  }
}
