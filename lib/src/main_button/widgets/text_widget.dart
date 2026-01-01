import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final TextStyle labelStyle;

  const TextWidget({super.key, required this.label, required this.labelStyle});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(label, maxLines: 1, style: labelStyle),
    );
  }
}
