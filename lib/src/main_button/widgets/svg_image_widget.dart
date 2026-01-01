import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImageWidget extends StatelessWidget {
  final String imagePath;
  final Color? imageColor;
  final double opacity;
  final double size;
  const SvgImageWidget({
    super.key,
    required this.imagePath,
    this.imageColor,
    required this.opacity,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: SvgPicture.asset(
        imagePath,
        width: size,
        height: size,
        colorFilter: imageColor != null
            ? ColorFilter.mode(imageColor!, BlendMode.srcIn)
            : null,
      ),
    );
  }
}
