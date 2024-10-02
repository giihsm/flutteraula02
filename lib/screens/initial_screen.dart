import 'package:flutter/material.dart';
import 'package:flutteraula02/components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _State();
}

class _State extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tarefas'),
      ),
      body: AnimatedOpacity(
          opacity: opacidade ? 1 : 0,
          duration: const Duration(milliseconds: 800),
        child: ListView(
          children: const [
            Task(
              "Aprender Flutter",
              'assets/images/flutter.png',
              2),
            Task(
                "Aprender Dart",
                'assets/images/dart.png',
                3),
            Task(
                "Aprender Kotlin",
                'assets/images/kotlin.png',
                5),
            Task(
                "Aprender Python",
                'assets/images/python.png',
                1),
            Task(
                "Aprender React",
                'assets/images/react.png',
                4),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              opacidade = !opacidade;
            });
          },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}
