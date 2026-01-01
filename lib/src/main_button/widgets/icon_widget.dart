import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double size;
  const IconWidget({
    super.key,
    required this.icon,
    this.iconColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: iconColor, size: size);
  }
}
