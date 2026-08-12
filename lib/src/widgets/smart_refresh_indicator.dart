import 'package:flutter/material.dart';

class WBRefreshIndicator extends StatelessWidget {
  /// The widget to display as the main content when the [RefreshIndicator] is not active.
  final Widget child;

  /// The callback function that is triggered when the user performs a pull-to-refresh action.
  /// This function should handle the logic for refreshing the data.
  final Future<void> Function() onRefresh;

  /// The color of the spinner. Defaults to the theme primary color so it stays
  /// visible on light backgrounds.
  final Color? color;

  /// The background disc color behind the spinner.
  final Color? backgroundColor;

  const WBRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // Function called when the user performs the pull-to-refresh gesture.
      onRefresh: onRefresh,

      // The color of the refresh indicator (visible on light backgrounds).
      color: color ?? Theme.of(context).primaryColor,
      backgroundColor: backgroundColor,

      // The main content widget that will be displayed when not in the refreshing state.
      child: child,
    );
  }
}
