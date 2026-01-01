import 'package:flutter/material.dart';

import '../functions/get_button_color.dart';
import 'elevated_button_widget.dart';
import 'image_widget.dart';
import 'text_widget.dart';

part 'main_icon_button.dart';

/// MainButtonEnum - primary - secondary - tertiary
enum MainButtonEnum { primary, secondary, tertiary }

class MainButton extends ElevatedButtonWidget {
  final String label;
  final TextStyle? labelStyle;
  final double? fontSize;
  final Color? disableLabelColor;

  const MainButton({
    required this.label,
    this.labelStyle,
    this.fontSize,
    this.disableLabelColor,
    super.key,
    super.width,
    super.maxWidth,
    super.height,
    super.contentPadding,
    super.radius,
    super.onPressed,
    super.backgroundColor,
    super.disableColor,
    super.isLoading,
    super.showShadow,
    super.isDisable,
    super.smallSize,
    super.borderColor,
    super.opacity,
    super.type,
    super.labelColor,
    super.child,
  });

  factory MainButton.icon({
    required String label,
    required IconType iconType,
    double? width,
    TextStyle? labelStyle,
    double? fontSize,

    ///  maximum width  => default value is 370
    double? maxWidth,
    double? radius,
    double? height,
    bool? smallSize,
    double? spaceBetweenIconAndText,
    String? imagePath,
    IconData? icon,
    void Function()? onPressed,
    double? imageSize,
    double? opacity,
    Color? textColor,
    Color? backgroundColor,
    EdgeInsets? padding,
    Color? disableColor,
    bool? isLoading,
    bool? showShadow,
    bool? isDisable,
    Color? borderColor,
    MainButtonEnum? type,
    Color labelColor = Colors.white,
    Color? disableLabelColor,
    Color? iconColor,
    bool isIconEnd = false,
  }) {
    return _MainIconButton(
      isIconEnd: isIconEnd,
      iconColor: iconColor ?? labelColor,
      width: width,
      labelStyle: labelStyle,

      ///  maximum width  => default value is 370
      maxWidth: maxWidth,
      iconType: iconType,
      label: label,
      imagePath: imagePath,
      icon: icon,
      imageSize: imageSize,
      onPressed: onPressed,
      height: height,
      contentPadding: padding,
      radius: radius,
      backgroundColor: backgroundColor,
      disableColor: disableColor,
      isLoading: isLoading,
      showShadow: showShadow,
      isDisable: isDisable,
      borderColor: borderColor,
      smallSize: smallSize,
      opacity: opacity,
      spaceBetween: spaceBetweenIconAndText,
      type: type,
      fontSize: fontSize,
      labelColor: labelColor,
      disableLabelColor: disableLabelColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final typeValue = type ?? MainButtonEnum.primary;
    return ElevatedButtonWidget(
      ///  width  => default value is double.infinity
      maxWidth: maxWidth,

      ///  width  => default value is double.infinity
      width: width,
      height: height,
      contentPadding: contentPadding,
      radius: radius,
      backgroundColor: backgroundColor,
      disableColor: disableColor,
      isLoading: isLoading,
      showShadow: showShadow,
      isDisable: isDisable,
      borderColor: borderColor,
      smallSize: smallSize,
      opacity: opacity,
      type: type,
      onPressed: onPressed,
      child:
          child ??
          TextWidget(
            label: label,
            labelStyle:
                labelStyle ??
                Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: (isDisable ?? false)
                      ? (disableLabelColor ?? Colors.white)
                      : getTextColor(typeValue, context, color: labelColor),
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                  height: 0.0,
                ),
          ),
    );
  }
}

///  width  => default value is double.infinity
///
///  maximum width  => default value is 370
///
///  height  => default value is 44
///
///  padding => const EdgeInsets.all(12).
///
///  radius  => default value is 10
///
/// A callback function that is triggered when the button is pressed.
///
///  borderColor => default value is Colors.transparent
///
/// isLoading => default value is false
///
/// showShadow => default value is false
///
/// type => default value is MainButtonEnum.primary
///
/// labelColor => default value is Colors.white
///
/// smallSize => default value is false
///
/// borderColor => default value is Colors.transparent
///
/// opacity => default value is null
///
