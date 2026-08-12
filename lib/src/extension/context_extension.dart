import 'package:flutter/material.dart';

extension TextExtension on BuildContext {
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;

  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;

  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
}

extension IsDarkTheme on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

extension Pop on BuildContext {
  void popScreen() => Navigator.maybePop(this);
}

extension CapitalLetterExtension on String {
  String get toCapitalLetter => isEmpty
      ? this
      : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}

extension MobileType on BuildContext {
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
}

extension PushNamed on BuildContext {
  Future<dynamic> pushNamed({required String routeName, Object? args}) =>
      Navigator.of(this).pushNamed(routeName, arguments: args);

  Future<T?> pushNamedThenExecute<T>({
    required String routeName,
    Object? args,
    VoidCallback? onThen,
  }) => Navigator.of(this).pushNamed(routeName, arguments: args).then((_) {
    onThen?.call();
    return null;
  });
}

extension Push on BuildContext {
  Future<dynamic> push(Widget screen) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (context) => screen));
}
