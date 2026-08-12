import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'smart_loading_widget.dart';

/// A widget that displays a cached network image with optional placeholders,
/// error handling, and image filtering.
///
/// The [WBCachedImage] widget wraps the [CachedNetworkImage] widget and
/// provides additional customization options such as setting border radius,
/// filter color, and HTTP headers. It supports graceful loading with a
/// placeholder and error handling with a fallback widget.
///
/// Example usage:
/// ```dart
/// WBCachedImage(
///   imageUrl: 'https://example.com/image.jpg',
///   width: 100,
///   height: 100,
///   radius: 8,
///   filterColor: Colors.black54,
///   placeholder: CircularProgressIndicator(),
///   errorWidget: Icon(Icons.error_outline),
/// )
/// ```
class WBCachedImage extends StatelessWidget {
  /// The URL (or asset/file path) of the image. When null or empty, [fallback]
  /// (or [errorWidget]) is shown instead — matching the null→logo behavior the
  /// consuming apps rely on.
  final String? imageUrl;

  /// The width of the image. If null, the image will be sized to fit.
  final double? width;

  /// The height of the image. If null, the image will be sized to fit.
  final double? height;

  /// The corner radius to apply to the image.
  final double radius;

  /// Optional [BorderRadiusGeometry] to define custom border radius.
  final BorderRadiusGeometry? borderRadius;

  /// How the image should be inscribed into the given space.
  final BoxFit fit;

  /// A color filter to apply to the image. Defaults to [Colors.transparent].
  final Color filterColor;
  final Color? color;

  /// A widget to display while the image is loading.
  final Widget placeholder;

  /// A widget to display if the image fails to load.
  final Widget errorWidget;

  /// HTTP headers to include in the network request.
  /// Defaults to allowing cross-origin access.
  final Map<String, String> httpHeaders;

  /// Creates a [WBCachedImage] widget.
  ///
  /// [imageUrl] is required. Optional parameters allow customization of
  /// the image's appearance and behavior.
  /// Fade-in duration for the loaded network image.
  final Duration fadeInDuration;

  /// Fade-out duration for the previous image while the new one loads.
  final Duration fadeOutDuration;

  /// Blend mode for the [color]/[filterColor] tint. Apps that tint avatars use
  /// [BlendMode.srcATop]; the historical default is [BlendMode.darken].
  final BlendMode blendMode;

  /// Shown when [imageUrl] is null/empty. Defaults to [errorWidget].
  final Widget? fallback;

  /// Decodes the network image at these cache dimensions (memory savings).
  final int? memCacheWidth;
  final int? memCacheHeight;

  /// Keeps the previous image on screen while a new URL loads (avoids flicker).
  final bool useOldImageOnUrlChange;

  const WBCachedImage({
    super.key,
    required this.imageUrl,
    @Deprecated("Use 'color' instead") this.filterColor = Colors.transparent,
    this.color = Colors.transparent,
    this.httpHeaders = const {"Access-Control-Allow-Origin": "*"},
    this.radius = 12,
    this.fit = BoxFit.cover,
    this.placeholder = const WBLoading(),
    this.errorWidget = const Icon(Icons.error),
    this.height,
    this.width,
    this.borderRadius,
    this.fadeInDuration = const Duration(milliseconds: 250),
    this.fadeOutDuration = const Duration(milliseconds: 100),
    this.blendMode = BlendMode.darken,
    this.fallback,
    this.memCacheWidth,
    this.memCacheHeight,
    this.useOldImageOnUrlChange = true,
  });

  bool get _hasSource => imageUrl != null && imageUrl!.trim().isNotEmpty;
  bool get _isSvg =>
      imageUrl!.toLowerCase().split('?').first.endsWith('.svg');
  bool get _isNetwork =>
      imageUrl!.startsWith('http://') || imageUrl!.startsWith('https://');
  bool get _isAsset => imageUrl!.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    Widget image = _hasSource ? _resolveImage() : (fallback ?? errorWidget);

    // Only wrap in a color filter when an actual tint is requested — a
    // transparent tint is a no-op layer and (worse) surprises callers who
    // pass a light color expecting a wash.
    final tint = color ?? filterColor;
    if (tint != Colors.transparent) {
      image = ColorFiltered(
        colorFilter: ColorFilter.mode(tint, blendMode),
        child: image,
      );
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
      child: image,
    );
  }

  /// Resolves the right image widget from the source: network SVG, asset SVG,
  /// asset raster, local file, or a cached network image.
  Widget _resolveImage() {
    if (_isSvg) {
      if (_isNetwork) {
        return SvgPicture.network(
          imageUrl!,
          width: width,
          height: height,
          fit: fit,
          placeholderBuilder: (_) => placeholder,
        );
      }
      return SvgPicture.asset(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
      );
    }

    if (_isAsset) {
      return Image.asset(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => errorWidget,
      );
    }

    if (!_isNetwork) {
      // A filesystem path (e.g. a freshly picked image).
      return Image.file(
        File(imageUrl!),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => errorWidget,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      httpHeaders: httpHeaders,
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      placeholder: (context, url) => placeholder,
      errorWidget: (context, url, error) => fallback ?? errorWidget,
    );
  }
}
