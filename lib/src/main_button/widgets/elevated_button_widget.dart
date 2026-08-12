import 'package:flutter/material.dart';

import '../../config/main_config.dart';
import 'main_button.dart';
import '../decoration/button_style_class.dart';
import '../functions/get_button_color.dart';
import 'circular_indicator_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  ///  width  => default value is double.infinity
  final double? width;

  ///  maximum width  => default value is 370
  final double? maxWidth;

  ///  height  => default value is 44
  final double? height;

  /// padding => const EdgeInsets.all(12).
  final EdgeInsets? contentPadding;

  /// radius  => default value is 10
  final double? radius;

  /// A callback function that is triggered when the button is pressed.
  final void Function()? onPressed;

  final Color? backgroundColor;

  /// disableColor => default value is Colors.grey.shade300
  final Color? disableColor;

  /// isLoading => default value is false
  final bool? isLoading;

  /// showShadow => default value is false
  final bool? showShadow;

  /// borderColor => default value is Colors.transparent
  final Color? borderColor;

  /// smallSize => default value is false
  final bool? smallSize;

  /// isDisable => default value is false
  final bool? isDisable;

  /// opacity => default value is null

  final double? opacity;

  /// type => default value is WBButtonType.primary
  final WBButtonType? type;

  final Widget? child;

  /// labelColor => default value is Colors.white
  final Color? labelColor;

  /// Optional gradient background. When set it paints behind the button and the
  /// solid background color is made transparent so the gradient shows through.
  final Gradient? gradient;

  /// Accessibility / UI-test identifier for the button.
  final String? semanticsIdentifier;

  /// Called on a long press.
  final void Function()? onLongPress;

  /// Focus node for the button.
  final FocusNode? focusNode;

  /// Whether the button grabs focus on first build.
  final bool autofocus;

  const ElevatedButtonWidget({
    super.key,
    this.width,

    ///  maximum width  => default value is 370
    this.maxWidth,
    this.height,
    this.contentPadding,
    this.radius,
    this.child,
    this.onPressed,
    this.backgroundColor,
    this.labelColor,
    this.disableColor,
    this.isLoading,
    this.showShadow,
    this.isDisable,
    this.smallSize,
    this.borderColor,
    this.opacity,
    this.type,
    this.gradient,
    this.semanticsIdentifier,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final config = WidgetsBoxConfigProvider.of(context);
    final typeValue = type ?? WBButtonType.primary;
    // Resolution order: widget prop -> ButtonConfig -> top-level -> default.
    final resolvedRadius = radius ??
        config.buttonConfig?.radius ??
        config.radius ??
        WidgetsBoxConfig.defaults.radius!;
    final resolvedHeight = height ??
        config.buttonConfig?.height ??
        config.height ??
        WidgetsBoxConfig.defaults.height!;
    final resolvedMaxWidth = maxWidth ??
        config.buttonConfig?.width ??
        config.width ??
        WidgetsBoxConfig.defaults.width!;
    final resolvedPadding = contentPadding ??
        config.buttonConfig?.contentPadding ??
        config.contentPadding ??
        const EdgeInsets.all(12);
    final Widget decorated = DecoratedBox(
      decoration: ShapeDecoration(
        // ShapeDecoration forbids color + gradient together.
        color: gradient != null ? null : Colors.transparent,
        gradient: gradient,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(resolvedRadius)),
        ),
        shadows: !(showShadow ?? false)
            ? null
            : const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
      ),
      child: ElevatedButton(
        style: ButtonStyleClass(
          width: width ?? double.infinity,
          maxWidth: resolvedMaxWidth,
          height: resolvedHeight,
          radius: resolvedRadius,
          labelColor: getTextColor(typeValue, context, color: labelColor),
          borderColor: getBorderColor(typeValue, context, color: borderColor),
          // When a gradient is supplied, keep the button surface transparent so
          // the gradient behind it shows through.
          background: gradient != null
              ? Colors.transparent
              : getBackgroundColor(
                  typeValue,
                  context,
                  color: backgroundColor,
                ),
          context: context,
          smallSize: smallSize ?? false,
          opacity: opacity,
          contentPadding: resolvedPadding,
          disableColor: disableColor ?? Colors.grey.shade100,
          disableLabelColor: config.buttonConfig?.disableLabelColor,
        ).apply,
        onPressed: (isLoading ?? false) || (isDisable ?? false)
            ? null
            : onPressed,
        onLongPress: (isLoading ?? false) || (isDisable ?? false)
            ? null
            : onLongPress,
        focusNode: focusNode,
        autofocus: autofocus,
        child: (isLoading ?? false)
            ? SizedBox(
                width: (smallSize ?? false) ? 60 : null,
                height: (smallSize ?? false) ? 40 : resolvedHeight,
                child: CircularIndicatorWidget(
                  color: getLoadingColor(typeValue, context, color: labelColor),
                ),
              )
            : child,
      ),
    );
    if (semanticsIdentifier == null) return decorated;
    return Semantics(identifier: semanticsIdentifier, child: decorated);
  }
}
