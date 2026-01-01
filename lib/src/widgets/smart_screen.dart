import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../widgets_box.dart';

enum LoadingType { skeleton, indicator }

class SmartScreen extends StatelessWidget {
  /// Indicates whether the data is currently being loaded.
  final bool isLoading;

  /// Indicates whether the data is currently being loaded.
  final LoadingType loadingType;

  /// Indicates whether the data is empty.
  final bool isEmpty;

  /// The main content to display when data is available.
  final Widget Function(BuildContext context) builder;

  /// Callback function that is triggered when the user performs a pull-to-refresh action.
  final Future<void> Function()? onRefresh;

  /// A custom widget to display when the data is empty. If not provided, a default empty screen will be used.
  final Widget? emptyWidget;

  /// A custom widget to display when the data is loading. If not provided, a default loading indicator will be used.
  final Widget? loadingWidget;

  /// A custom widget to display when the data is empty. If not provided, a default empty screen will be used.
  final EmptyType emptyWidgetType;

  /// An optional message to display in the empty state widget.
  final String? message;
  final Color? refreshColor;
  final Color? refreshBackgroundColor;
  final Widget? skeletonWidget;
  final Color? skeletonColor;
  final double textBorderRadius;

  const SmartScreen({
    super.key,
    required this.builder,
    this.isLoading = false,
    this.loadingType = LoadingType.skeleton,
    this.isEmpty = false,
    this.message,
    this.emptyWidget,
    this.onRefresh,
    this.refreshColor,
    this.refreshBackgroundColor,
    this.loadingWidget,
    this.emptyWidgetType = EmptyType.image,
    this.skeletonWidget,
    this.skeletonColor,
    this.textBorderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return getWidget(
      isLoading: isLoading,
      loadingType: loadingType,
      isEmpty: isEmpty,
      builder: builder,
      message: message,
      emptyWidget: emptyWidget,
      onRefresh: onRefresh,
      context: context,
      refreshColor: refreshColor,
      refreshBackgroundColor: refreshBackgroundColor,
      loadingWidget: loadingWidget,
      skeletonWidget: skeletonWidget,
      skeletonContainerColor: skeletonColor,
      textBorderRadius: textBorderRadius,
      emptyWidgetType: emptyWidgetType,
    );
  }
}

/// A function that returns a widget based on the state of loading, empty content,
/// or displaying data.
///
/// - If [isLoading] is true, it returns a [Skeletonizer] wrapping the [skeletonWidget] or [builder].
/// - If [isEmpty] is true, it returns the [emptyWidget] if provided, or the default [SmartEmptyWidget].
/// - Otherwise, it returns the main content wrapped with a [RefreshIndicator] for pull-to-refresh functionality.
Widget getWidget({
  required BuildContext context,
  required bool isLoading,
  required LoadingType loadingType,
  required bool isEmpty,
  required Widget Function(BuildContext context) builder,
  required Widget? emptyWidget,
  required Widget? loadingWidget,
  required String? message,
  required Color? refreshColor,
  required Color? refreshBackgroundColor,
  required Future<void> Function()? onRefresh,
  required Widget? skeletonWidget,
  required Color? skeletonContainerColor,
  required double textBorderRadius,
  required EmptyType emptyWidgetType,
}) {
  if (isLoading) {
    if (loadingWidget != null) return loadingWidget;

    if (loadingType == LoadingType.indicator) {
      return const SmartLoadingWidget();
    }

    // Displays a loading widget when data is being fetched.
    return Skeletonizer(
      enabled: isLoading,
      containersColor: skeletonContainerColor,
      textBoneBorderRadius: TextBoneBorderRadius(
        BorderRadius.circular(textBorderRadius),
      ),
      child: skeletonWidget != null
          ? Builder(builder: (context) => skeletonWidget)
          : builder(context),
    );
  } else if (isEmpty) {
    // Displays an empty state widget if there is no data.
    return emptyWidget ??
        SmartEmptyWidget(title: message, type: emptyWidgetType);
  } else {
    // Displays the main content wrapped with a pull-to-refresh functionality.
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      color: refreshColor ?? Theme.of(context).primaryColor,
      backgroundColor: refreshBackgroundColor ?? Theme.of(context).cardColor,
      child: builder(context),
    );
  }
}
