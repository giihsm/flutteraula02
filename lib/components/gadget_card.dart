import 'package:flutter/material.dart';

class GadgetCard extends StatelessWidget {
  final String name;
  final String description;

  GadgetCard({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text(description),
      ),
    );
  }
}