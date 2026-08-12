import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// An icon centered in a rounded, tinted square — the "icon chip" every app
/// re-implements for list leadings, feature tiles and empty states.
///
/// Provide a Material [icon], an [svgAsset], or an arbitrary [child]. The
/// background defaults to a faded tint of the icon [color]; the whole box is
/// tappable when [onTap] is given.
class WBIconBox extends StatelessWidget {
  final IconData? icon;
  final String? svgAsset;
  final Widget? child;

  /// Outer box side length. Defaults to 40.
  final double size;

  /// Glyph size. Defaults to `size * 0.5`.
  final double? iconSize;

  /// Foreground (icon) color. Defaults to the theme primary.
  final Color? color;

  /// Box background. Defaults to a 12% tint of [color].
  final Color? backgroundColor;

  final double radius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const WBIconBox({
    super.key,
    this.icon,
    this.svgAsset,
    this.child,
    this.size = 40,
    this.iconSize,
    this.color,
    this.backgroundColor,
    this.radius = 12,
    this.padding,
    this.onTap,
  });

  /// Convenience constructor for an SVG asset glyph.
  const WBIconBox.svg(
    String asset, {
    Key? key,
    double size = 40,
    double? iconSize,
    Color? color,
    Color? backgroundColor,
    double radius = 12,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
  }) : this(
          key: key,
          svgAsset: asset,
          size: size,
          iconSize: iconSize,
          color: color,
          backgroundColor: backgroundColor,
          radius: radius,
          padding: padding,
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? Theme.of(context).colorScheme.primary;
    final glyphSize = iconSize ?? size * 0.5;

    Widget? glyph = child;
    glyph ??= icon != null
        ? Icon(icon, size: glyphSize, color: resolvedColor)
        : svgAsset != null
            ? SvgPicture.asset(
                svgAsset!,
                width: glyphSize,
                height: glyphSize,
                colorFilter:
                    ColorFilter.mode(resolvedColor, BlendMode.srcIn),
              )
            : null;

    final box = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? resolvedColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: glyph,
    );

    if (onTap == null) return box;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: box,
    );
  }
}
