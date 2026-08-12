import 'package:flutter/material.dart';

import '../config/main_config.dart';

/// Visual treatment for [WBCard].
enum WBCardStyle {
  /// A soft drop shadow on a filled surface (default).
  elevated,

  /// A 1px outline on a filled surface, no shadow.
  bordered,

  /// A filled surface with no shadow or border.
  flat,
}

/// A configurable content card that captures the `Container(decoration: …)` +
/// padding (+ optional tap / status / leading) shape every consuming app
/// currently re-implements locally.
///
/// Styling resolves through the Theme → config → local-override hierarchy:
/// per-instance props win, then [WBCardConfig] from [WidgetsBoxConfigProvider],
/// then the widget's built-in defaults (radius 16, padding 16, `Theme.cardColor`).
///
/// ```dart
/// WBCard(child: Text('Hello'));
/// WBCard(
///   style: WBCardStyle.bordered,
///   onTap: () {},
///   status: WBStatusBadge(label: 'Paid'),
///   child: ...,
/// );
/// WBCard.media(image: Image.network(url), child: Text('Title'));
/// ```
class WBCard extends StatelessWidget {
  /// The card's main content.
  final Widget child;

  /// Visual treatment. Defaults to [WBCardStyle.elevated].
  final WBCardStyle style;

  /// Inner padding. Falls back to config, then `EdgeInsets.all(16)`.
  final EdgeInsetsGeometry? padding;

  /// Outer margin. Defaults to none.
  final EdgeInsetsGeometry? margin;

  /// Corner radius. Falls back to config, then 16.
  final double? radius;

  /// Background color. Falls back to config, then `Theme.cardColor`.
  final Color? color;

  /// Tapped callback. When set, the card gets an ink ripple clipped to its
  /// shape.
  final VoidCallback? onTap;

  /// Optional widget pinned to the top-end corner (e.g. a status badge),
  /// overlaid without affecting the content layout.
  final Widget? status;

  /// Optional leading widget placed before [child] in a row (e.g. an avatar or
  /// thumbnail). When null, [child] fills the card.
  final Widget? leading;

  /// Spacing between [leading] and [child]. Defaults to 12.
  final double leadingSpacing;

  /// Cross-axis alignment of the leading/content row. Defaults to center.
  final CrossAxisAlignment crossAxisAlignment;

  /// Fixed width; when null the card sizes to its content.
  final double? width;

  /// Fixed height; when null the card sizes to its content.
  final double? height;

  /// Alignment of [child] within a fixed-size card.
  final AlignmentGeometry? alignment;

  /// Clip behavior for the card surface. Defaults to [Clip.antiAlias] so
  /// children (e.g. images) are clipped to the rounded corners.
  final Clip clipBehavior;

  /// Extra size constraints for the card.
  final BoxConstraints? constraints;

  const WBCard({
    super.key,
    required this.child,
    this.style = WBCardStyle.elevated,
    this.padding,
    this.margin,
    this.radius,
    this.color,
    this.onTap,
    this.status,
    this.leading,
    this.leadingSpacing = 12,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.width,
    this.height,
    this.alignment,
    this.clipBehavior = Clip.antiAlias,
    this.constraints,
  });

  /// A media card: a sized [image] leading slot next to [child], with an
  /// optional [status] overlay — the `CardWidget.one..four` list-card shape
  /// several apps ship.
  factory WBCard.media({
    Key? key,
    required Widget image,
    required Widget child,
    double imageSize = 64,
    WBCardStyle style = WBCardStyle.elevated,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? radius,
    Color? color,
    VoidCallback? onTap,
    Widget? status,
    double leadingSpacing = 12,
  }) {
    return WBCard(
      key: key,
      style: style,
      padding: padding,
      margin: margin,
      radius: radius,
      color: color,
      onTap: onTap,
      status: status,
      leadingSpacing: leadingSpacing,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular((radius ?? 16) - 4),
        child: SizedBox.square(dimension: imageSize, child: image),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardConfig = WidgetsBoxConfigProvider.of(context).cardConfig;

    final resolvedRadius = radius ?? cardConfig?.radius ?? 16;
    final resolvedPadding =
        padding ?? cardConfig?.padding ?? const EdgeInsets.all(16);
    final resolvedColor = color ?? cardConfig?.color ?? theme.cardColor;
    final borderRadius = BorderRadius.circular(resolvedRadius);

    final Widget content = leading == null
        ? child
        : Row(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              leading!,
              SizedBox(width: leadingSpacing),
              Expanded(child: child),
            ],
          );

    Widget card = Container(
      width: width,
      height: height,
      alignment: alignment,
      constraints: constraints,
      clipBehavior: clipBehavior,
      decoration: _decoration(theme, cardConfig, resolvedColor, borderRadius),
      padding: resolvedPadding,
      child: content,
    );

    if (onTap != null) {
      // Material + InkWell over the decoration gives a ripple clipped to the
      // card shape without painting a second background.
      card = Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            card,
            Positioned.fill(
              child: InkWell(borderRadius: borderRadius, onTap: onTap),
            ),
          ],
        ),
      );
    }

    if (status != null) {
      card = Stack(
        clipBehavior: Clip.none,
        children: [
          card,
          PositionedDirectional(top: 8, end: 8, child: status!),
        ],
      );
    }

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    return card;
  }

  BoxDecoration _decoration(
    ThemeData theme,
    WBCardConfig? config,
    Color background,
    BorderRadius borderRadius,
  ) {
    switch (style) {
      case WBCardStyle.elevated:
        return BoxDecoration(
          color: background,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: config?.shadowColor ??
                  theme.shadowColor.withValues(alpha: 0.08),
              blurRadius: config?.elevation ?? 12,
              offset: const Offset(0, 4),
            ),
          ],
        );
      case WBCardStyle.bordered:
        return BoxDecoration(
          color: background,
          borderRadius: borderRadius,
          border: Border.all(
            color: config?.borderColor ?? theme.dividerColor,
            width: config?.borderWidth ?? 1,
          ),
        );
      case WBCardStyle.flat:
        return BoxDecoration(color: background, borderRadius: borderRadius);
    }
  }
}
