import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/main_config.dart';

class PrefixIconWidget extends StatelessWidget {
  final IconData? icon;
  final String? assetPath;
  final Color? color;

  const PrefixIconWidget({super.key, this.assetPath, this.color, this.icon})
    : assert(
        icon != null || assetPath != null,
        'Either icon or assetPath must be provided',
      );

  @override
  Widget build(BuildContext context) {
    final config = WidgetsBoxConfigProvider.of(context).textFieldConfig;
    final iconColor =
        color ?? config?.iconColor ?? Theme.of(context).primaryColor;
    final iconPadding = config?.iconPadding ?? 10.0;
    final iconSize = config?.iconSize ?? 20;
    Widget child;

    if (assetPath != null) {
      if (assetPath!.endsWith('.svg')) {
        child = SvgPicture.asset(
          assetPath!,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          width: iconSize,
          height: iconSize,
        );
      } else {
        child = Image.asset(
          assetPath!,
          color: iconColor,
          width: iconSize,
          height: iconSize,
        );
      }
    } else {
      child = Icon(icon, color: iconColor, size: iconSize);
    }
    return Padding(padding: EdgeInsets.all(iconPadding), child: child);
  }
}

Widget? buildPrefixIcon({
  required BuildContext context,
  required String? assetPath,
  required IconData? icon,
  required Color? color,
  required bool? showIcon,
}) {
  final config = WidgetsBoxConfigProvider.of(context).textFieldConfig;

  final isShow = config?.showIcon ?? showIcon ?? false;
  if (!isShow) return null;

  return PrefixIconWidget(assetPath: assetPath, icon: icon, color: color);
}
