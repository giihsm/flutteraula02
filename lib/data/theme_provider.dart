import 'package:flutter/material.dart';

class ThemeProvider extends InheritedWidget {
  final Color themeColor;

  ThemeProvider({
    super.key,
    required this.themeColor,
    required Widget child,
  }) : super(child: child);

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return themeColor != oldWidget.themeColor;
  }
}