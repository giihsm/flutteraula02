import 'package:flutter/material.dart';
import 'package:flutteraula02/data/task_inherited.dart';
import 'package:flutteraula02/screens/splash_screen.dart';

import 'components/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> initialTasks = [];

    void updateList(List<Task> newTasks) {
      initialTasks = newTasks;
    }

    return TaskInherited(

      child: MaterialApp(
        title: 'App com telas',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
