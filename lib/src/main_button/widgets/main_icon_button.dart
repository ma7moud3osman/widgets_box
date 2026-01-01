part of 'main_button.dart';

/// A custom icon button widget that provides a variety of styling and functionality options.
///
/// This button supports various states such as loading and disabled, allows customization
/// of its appearance through properties like padding, border radius, and colors, and can display
/// either an image, an icon, or text.
class _MainIconButton extends MainButton {
  /// The path to an image asset to be displayed inside the button. If `null`, no image will be shown.
  final String? imagePath;

  /// A widget that is used as an icon inside the button. If `null`, no icon will be shown.
  final IconData? icon;
  final Color? iconColor;

  /// The imageSize of the button. This controls how transparent the button is. If `null`, a default opacity will be used.
  final double? imageSize;
  final double? spaceBetween;
  final bool isIconEnd;

  final IconType iconType;

  const _MainIconButton({
    required this.imagePath,
    required this.icon,
    required this.imageSize,
    required this.iconType,
    required this.iconColor,
    this.spaceBetween,
    this.isIconEnd = false,
    super.width,

    ///  maximum width  => default value is 370
    super.maxWidth,
    required super.height,
    required super.contentPadding,
    required super.radius,
    required super.onPressed,
    required super.backgroundColor,
    required super.disableColor,
    required super.isLoading,
    required super.showShadow,
    required super.isDisable,
    required super.borderColor,
    super.smallSize,
    required super.opacity,
    required super.label,
    super.type,
    required super.labelStyle,
    super.fontSize,
    required super.disableLabelColor,
    required super.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonWidget(
      ///  maximum width  => default value is 370
      maxWidth: maxWidth,
      width: width,
      height: height ?? 44,
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
      type: type ?? MainButtonEnum.primary,
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: icon == null
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.center,
            children: isIconEnd
                ? [
                    TextWidget(
                      label: label,
                      labelStyle:
                          labelStyle ??
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: (isDisable ?? false)
                                ? disableLabelColor
                                : labelColor,
                            fontWeight: FontWeight.w600,
                            fontSize: fontSize,
                            height: 0.0,
                          ),
                    ),
                    SizedBox(width: spaceBetween),
                    ImageWidget(
                      iconType: iconType,
                      imagePath: imagePath,
                      imageSize: imageSize ?? 24,
                      opacity: opacity,
                      icon: icon,
                      iconColor:
                          iconColor ??
                          Theme.of(context).textTheme.labelMedium!.color,
                    ),
                  ]
                : [
                    ImageWidget(
                      iconType: iconType,
                      imagePath: imagePath,
                      imageSize: imageSize ?? 24,
                      opacity: opacity,
                      icon: icon,
                      iconColor:
                          iconColor ??
                          Theme.of(context).textTheme.labelMedium!.color,
                    ),
                    SizedBox(width: spaceBetween),
                    TextWidget(
                      label: label,
                      labelStyle:
                          labelStyle ??
                          Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: (isDisable ?? false)
                                ? disableLabelColor
                                : labelColor,
                            fontWeight: FontWeight.w600,
                            fontSize: fontSize,
                            height: 0.0,
                          ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
