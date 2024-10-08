import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutteraula02/components/task.dart';

Image imageFromBase64String(String base64String) {
  Uint8List bytes = base64.decode(base64String);
  return Image.memory(
    bytes,
    fit: BoxFit.cover,
  );
}

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.nome),
      subtitle: Text('Dificuldade: ${task.dificuldade}'),
      leading: task.foto.isNotEmpty
          ? SizedBox(
        width: 40,
        height: 40,
        child: _buildLeadingImage(task.foto),
      )
          : null,
    );
  }

  Widget _buildLeadingImage(String foto) {
    if (foto.startsWith('data:image')) {
      return imageFromBase64String(foto.split(',').last);
    } else {
      return Image.network(
        foto,
        fit: BoxFit.cover,
      );
    }
  }
}
