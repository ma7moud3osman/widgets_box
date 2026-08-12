import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_localize/smart_localize.dart';

/// Enum that defines the type of empty state to display.
enum EmptyType {
  /// Custom empty state that allows using a custom widget.
  custom,

  /// Empty state that displays an image with a message.
  image,

  /// Empty state that displays only a text message.
  text,
}

class SmartEmptyWidget extends StatelessWidget {
  /// The message to display in the empty state. Defaults to 'no_data_found' if not provided.
  final String? title;
  final String? subtitle;

  /// The file path to the image to be displayed when using [EmptyType.image].
  final String? emptyImage;

  /// The icon to be displayed when using [EmptyType.image].
  final IconData? icon;

  /// A custom widget to display when using [EmptyType.custom].
  final Widget? child;

  /// The padding around the content of the empty state.
  final EdgeInsetsGeometry? padding;

  /// Specifies the type of empty state to display.
  final EmptyType type;

  /// The text style to apply to the message.
  final TextStyle? messageStyle;

  /// The text style to apply to the title.
  final TextStyle? titleStyle;

  /// buttonWidget.
  final Widget? buttonWidget;

  /// When provided (and [buttonWidget] is null), renders a retry button that
  /// calls this — the common "empty because it failed, tap to retry" case.
  final VoidCallback? onRetry;

  /// Label for the built-in retry button. Defaults to a localized "Retry".
  final String? retryLabel;

  const SmartEmptyWidget({
    super.key,
    this.subtitle,
    this.title,
    this.child,
    this.padding,
    this.emptyImage,
    this.icon,
    this.type = EmptyType.text,
    this.messageStyle,
    this.titleStyle,
    this.buttonWidget,
    this.onRetry,
    this.retryLabel,
  });

  /// Wraps this empty state in a sliver so it can fill the viewport inside a
  /// `CustomScrollView` (a variant every app hand-rolls as `.toSliver`).
  Widget toSliver() =>
      SliverFillRemaining(hasScrollBody: false, child: this);

  Widget? _effectiveButton() {
    if (buttonWidget != null) return buttonWidget;
    if (onRetry != null) {
      return Builder(
        builder: (context) => FilledButton.tonalIcon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh, size: 18),
          label: Text(retryLabel ?? SmartLocalize.retry),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case EmptyType.image:
        // Displays an image with a message when using the EmptyType.image.
        return Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (emptyImage != null)
                  emptyImage!.toLowerCase().split('?').first.endsWith('.svg')
                      ? SvgPicture.asset(emptyImage!)
                      : Image.asset(emptyImage!)
                else
                  Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      icon ?? Icons.inbox_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                SizedBox(height: 24),

                Text(
                  title ?? SmartLocalize.noDataFound,
                  textAlign: TextAlign.center,
                  style: titleStyle ?? Theme.of(context).textTheme.labelLarge,
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 12),
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style:
                        messageStyle ?? Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                if (_effectiveButton() case final button?) ...[
                  SizedBox(height: 24),
                  button,
                ],
              ],
            ),
          ),
        );
      case EmptyType.text:
        // Displays only a text message when using the EmptyType.text.
        final button = _effectiveButton();
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? SmartLocalize.noDataFound,
                textAlign: TextAlign.center,
                style: messageStyle ?? Theme.of(context).textTheme.bodyMedium,
              ),
              if (button != null) ...[
                const SizedBox(height: 16),
                button,
              ],
            ],
          ),
        );
      case EmptyType.custom:
        // Displays a custom widget provided by the user when using the EmptyType.custom.
        return Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: Center(child: child!),
        );
    }
  }
}
