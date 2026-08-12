import 'package:flutter/material.dart';

import 'widget_box_config.dart';

export 'button_config.dart';
export 'card_config.dart';
export 'text_field_config.dart';
export 'toast_config.dart';
export 'widget_box_config.dart';

class WidgetsBoxConfigProvider extends InheritedWidget {
  final WidgetsBoxConfig config;

  const WidgetsBoxConfigProvider({
    super.key,
    required this.config,
    required super.child,
  });

  static WidgetsBoxConfig of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<WidgetsBoxConfigProvider>()
            ?.config ??
        WidgetsBoxConfig.defaults;
  }

  @override
  bool updateShouldNotify(WidgetsBoxConfigProvider oldWidget) {
    return config != oldWidget.config;
  }
}
