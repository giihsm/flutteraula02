import 'package:flutter/material.dart';

import '../data/app_data_inherited_widget.dart';


class AppDataManager extends StatefulWidget {
  final Widget child;

  AppDataManager({required this.child});

  @override
  _AppDataManagerState createState() => _AppDataManagerState();
}

class _AppDataManagerState extends State<AppDataManager> {
  List<String> gadgets = [];

  void addGadget(String gadget) {
    setState(() {
      gadgets.add(gadget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppDataInheritedWidget(
      gadgets: gadgets,
      addGadget: addGadget,
      child: widget.child,
    );
  }
}