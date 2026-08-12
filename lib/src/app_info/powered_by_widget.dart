import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A compact "Powered by GAIT" vendor signature — the muted caption and bold
/// wordmark rendered inline (`Powered by GAIT`) followed by the brand glyph,
/// always left-to-right, tappable to open [url].
///
/// This is a faithful, reusable port of the footer every app hand-rolls: the
/// caption in a muted grey, the wordmark in the brand navy (lightened on dark
/// backgrounds), and the monogram tinted to match. Everything is configurable
/// ([label]/[brand] text, [url], [style], [brandColor], [logo], [showLogo],
/// [spacing], [padding]) so any project can rebrand it, but the defaults
/// reproduce the GAIT signature exactly.
///
/// The caption and wordmark are intentionally English-only — this is a fixed
/// vendor signature, not translated copy — and it always renders LTR.
class WBPoweredBy extends StatelessWidget {
  /// The muted caption before the brand. Defaults to `'Powered by'`.
  final String label;

  /// The brand wordmark, rendered bold and used as the tap target.
  final String brand;

  /// Opened in an external browser when tapped. When null the signature is
  /// shown but not tappable.
  final String? url;

  /// Base text style for the whole signature. Defaults to `bodySmall` in a
  /// muted grey; the brand word overrides the color/weight on top of this.
  final TextStyle? style;

  /// Color of the [brand] word and the default logo tint. Defaults to the GAIT
  /// brand navy on light backgrounds and a lightened navy on dark ones.
  final Color? brandColor;

  /// Whether to show the brand glyph after the wordmark. Defaults to true.
  final bool showLogo;

  /// A custom glyph widget. When null (and [showLogo] is true) the bundled GAIT
  /// monogram is shown, tinted to the resolved brand color.
  final Widget? logo;

  /// Outer padding around the signature. Defaults to none.
  final EdgeInsetsGeometry? padding;

  /// Gap between the wordmark and the glyph. Defaults to 2.
  final double spacing;

  const WBPoweredBy({
    super.key,
    this.label = 'Powered by',
    this.brand = 'GAIT',
    this.url = 'https://gaitco.com/',
    this.style,
    this.brandColor,
    this.showLogo = true,
    this.logo,
    this.padding,
    this.spacing = 2,
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
    final brandColorResolved =
        brandColor ?? (isDark ? _gaitNavyOnDark : _gaitNavy);

    final baseStyle = style ??
        theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600);
    final double glyphSize = (baseStyle?.fontSize ?? 10) + 2;

    final glyph = showLogo
        ? (logo ??
            Image.asset(
              'assets/images/gait_logo.png',
              package: 'widgets_box',
              width: glyphSize,
              height: glyphSize,
              color: brandColorResolved,
              colorBlendMode: BlendMode.srcIn,
              // Degrade gracefully if the asset can't be resolved (e.g. a
              // hot-restart before a cold rebuild bundles it) instead of
              // throwing and leaving a broken-image box.
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ))
        : null;

    // FittedBox(scaleDown) guarantees the signature never overflows its parent,
    // regardless of the width the host layout gives it (Center, Row, a narrow
    // bottom bar, …). It keeps the natural size when there is room and only
    // scales down when space is tight.
    final content = Directionality(
      textDirection: TextDirection.ltr,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: spacing,
          children: [
            // Brand line is English-only by design; never localized.
            Text.rich(
              TextSpan(
                style: baseStyle,
                children: [
                  TextSpan(text: '$label '),
                  TextSpan(
                    text: brand,
                    style: baseStyle?.copyWith(
                      color: brandColorResolved,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            if (glyph != null) glyph,
          ],
        ),
      ),
    );

    final padded =
        padding != null ? Padding(padding: padding!, child: content) : content;

    if (url == null) return padded;
    return InkWell(onTap: _open, child: padded);
  }
}
