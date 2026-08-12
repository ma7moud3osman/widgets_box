import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A compact vendor signature — a muted "Powered by" caption, the bold brand
/// word, and the brand glyph — rendered inline and left-to-right, tappable to
/// open [url].
///
/// Everything is configurable so any project can reuse it with its own brand:
/// the [label]/[brand] text, the [url], the colors, the text styles, and the
/// [logo] glyph. By default it shows the bundled GAIT monogram tinted to the
/// brand color; pass [showLogo] `false` to hide it or [logo] to swap it.
///
/// The brand word and caption are intentionally not routed through any
/// localization — this is a fixed vendor signature, not translated copy, and it
/// always renders LTR regardless of the app's locale.
class WBPoweredBy extends StatelessWidget {
  /// The muted caption before the brand. Defaults to `'Powered by'`.
  final String label;

  /// The brand word rendered prominently and used as the tap target.
  final String brand;

  /// Opened in an external browser when tapped. When null the signature is
  /// shown but not tappable.
  final String? url;

  /// Color of the [label] caption. Defaults to a muted theme color.
  final Color? labelColor;

  /// Color of the [brand] word and the default logo tint. Defaults to the GAIT
  /// brand navy on light backgrounds and a lightened navy on dark ones.
  final Color? brandColor;

  /// Overrides the [label] text style (color still falls back to [labelColor]).
  final TextStyle? labelStyle;

  /// Overrides the [brand] text style (color still falls back to [brandColor]).
  final TextStyle? brandStyle;

  /// Whether to show the brand glyph beside the wordmark. Defaults to true.
  final bool showLogo;

  /// A custom glyph widget. When null (and [showLogo] is true) the bundled GAIT
  /// monogram is shown, tinted to the resolved brand color.
  final Widget? logo;

  /// Outer padding around the signature. Defaults to none.
  final EdgeInsetsGeometry? padding;

  /// Gap between the caption, wordmark and glyph. Defaults to 4.
  final double spacing;

  const WBPoweredBy({
    super.key,
    this.label = 'Powered by',
    this.brand = 'GAIT',
    this.url = 'https://gaitco.com',
    this.labelColor,
    this.brandColor,
    this.labelStyle,
    this.brandStyle,
    this.showLogo = true,
    this.logo,
    this.padding,
    this.spacing = 4,
  });

  /// GAIT brand navy (sampled from the logo), with a lightened variant so the
  /// wordmark and monogram stay legible on dark backgrounds.
  static const Color _gaitNavy = Color(0xFF001A4A);
  static const Color _gaitNavyOnDark = Color(0xFFB9C7E6);

  Future<void> _open() async {
    final target = url;
    if (target == null) return;
    final uri = Uri.tryParse(target);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final resolvedBrandColor =
        brandColor ?? (isDark ? _gaitNavyOnDark : _gaitNavy);

    final resolvedLabelStyle = (labelStyle ?? theme.textTheme.bodySmall)
        ?.copyWith(color: labelColor ?? theme.hintColor);
    final resolvedBrandStyle =
        (brandStyle ?? theme.textTheme.bodySmall)?.copyWith(
      color: resolvedBrandColor,
      fontWeight: FontWeight.w700,
    );

    final double glyphSize =
        (resolvedBrandStyle?.fontSize ?? resolvedLabelStyle?.fontSize ?? 12) + 2;

    final glyph = showLogo
        ? (logo ??
            Image.asset(
              'assets/images/gait_logo.png',
              package: 'widgets_box',
              width: glyphSize,
              height: glyphSize,
              color: resolvedBrandColor,
              colorBlendMode: BlendMode.srcIn,
            ))
        : null;

    final content = Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: resolvedLabelStyle),
          SizedBox(width: spacing),
          Text(brand, style: resolvedBrandStyle),
          if (glyph != null) ...[
            SizedBox(width: spacing),
            glyph,
          ],
        ],
      ),
    );

    final padded = padding != null
        ? Padding(padding: padding!, child: content)
        : content;

    if (url == null) return padded;
    return InkWell(
      onTap: _open,
      borderRadius: BorderRadius.circular(8),
      child: padded,
    );
  }
}
