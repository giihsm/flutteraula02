import 'package:flutter/material.dart';

class AppDataInheritedWidget extends InheritedWidget {
  final List<String> gadgets;
  final Function(String) addGadget;

  AppDataInheritedWidget({
    Key? key,
    required this.gadgets,
    required this.addGadget,
    required Widget child,
  }) : super(key: key, child: child);

  static AppDataInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDataInheritedWidget>();
  }

  @override
  bool updateShouldNotify(AppDataInheritedWidget oldWidget) {
    return oldWidget.gadgets != gadgets;
  }
}