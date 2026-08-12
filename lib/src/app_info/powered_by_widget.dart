import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A two-line vendor signature — a muted "Powered by" caption above a tappable
/// brand word that opens [url] in the browser.
///
/// Everything is configurable so any project can reuse it with its own brand:
/// the [label] and [brand] text, the [url], the two colors, and the text
/// styles. The brand word is intentionally not routed through any localization
/// — it is a fixed vendor signature, not translated copy.
class WBPoweredBy extends StatelessWidget {
  /// The muted caption above the brand. Defaults to `'Powered by'`.
  final String label;

  /// The brand word rendered prominently and used as the tap target.
  final String brand;

  /// Opened in an external browser when the brand is tapped. When null the
  /// brand is shown but not tappable.
  final String? url;

  /// Color of the [label] caption. Defaults to a muted theme color.
  final Color? labelColor;

  /// Color of the [brand] word. Defaults to the theme primary color.
  final Color? brandColor;

  /// Overrides the [label] text style (color still falls back to [labelColor]).
  final TextStyle? labelStyle;

  /// Overrides the [brand] text style (color still falls back to [brandColor]).
  final TextStyle? brandStyle;

  const WBPoweredBy({
    super.key,
    this.label = 'Powered by',
    this.brand = 'GAIT',
    this.url = 'https://gaitco.com',
    this.labelColor,
    this.brandColor,
    this.labelStyle,
    this.brandStyle,
  });

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
    final resolvedLabelStyle = (labelStyle ?? theme.textTheme.bodySmall)
        ?.copyWith(color: labelColor ?? theme.hintColor);
    final resolvedBrandStyle = (brandStyle ?? theme.textTheme.bodyMedium)
        ?.copyWith(
          color: brandColor ?? theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        );

    final brandText = Text(brand, style: resolvedBrandStyle);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: resolvedLabelStyle),
        if (url == null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: brandText,
          )
        else
          InkWell(
            onTap: _open,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: brandText,
            ),
          ),
      ],
    );
  }
}
