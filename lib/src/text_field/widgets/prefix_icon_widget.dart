import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets_box.dart';

class PrefixIconWidget extends StatelessWidget {
  final Color? color;
  final bool isShow;
  final String assetPath;

  const PrefixIconWidget({
    super.key,
    required this.assetPath,
    this.color,
    this.isShow = false,
  });

  @override
  Widget build(BuildContext context) {
    final config = WidgetsBoxConfigProvider.of(context).textFieldConfig;
    final iconColor =
        color ?? config?.iconColor ?? Theme.of(context).primaryColor;
    final iconPadding = config?.iconPadding ?? 10.0;
    final iconSize = config?.iconSize ?? 20;

    return config?.showIcon ?? isShow
        ? Padding(
            padding: EdgeInsets.all(iconPadding),
            child: SvgPicture.asset(
              assetPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              width: iconSize,
              height: iconSize,
              placeholderBuilder: (_) =>
                  const SizedBox(width: 20, height: 20, child: Icon(Icons.abc)),
            ),
          )
        : SizedBox.shrink();
  }
}
