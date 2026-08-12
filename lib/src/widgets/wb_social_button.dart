import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A bordered social/auth button — a leading glyph (Material [icon], [svgAsset]
/// or [imageAsset]) beside a label, with a built-in loading state. Folds the
/// `SocialAuthButtonWidget` every app re-implements for Google/Apple sign-in.
class WBSocialButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? svgAsset;
  final String? imageAsset;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double height;
  final double radius;
  final double iconSize;

  const WBSocialButton({
    super.key,
    required this.label,
    this.icon,
    this.svgAsset,
    this.imageAsset,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.height = 48,
    this.radius = 10,
    this.iconSize = 22,
  });

  Widget? _glyph(Color fg) {
    if (icon != null) return Icon(icon, size: iconSize, color: fg);
    if (svgAsset != null) {
      return SvgPicture.asset(svgAsset!, width: iconSize, height: iconSize);
    }
    if (imageAsset != null) {
      return Image.asset(imageAsset!, width: iconSize, height: iconSize);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = foregroundColor ?? theme.colorScheme.onSurface;
    final bg = backgroundColor ?? theme.colorScheme.surface;
    final glyph = _glyph(fg);

    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          side: BorderSide(color: borderColor ?? theme.dividerColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: iconSize,
                height: iconSize,
                child: CircularProgressIndicator(strokeWidth: 2, color: fg),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (glyph != null) ...[glyph, const SizedBox(width: 10)],
                  Flexible(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge
                          ?.copyWith(color: fg, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
