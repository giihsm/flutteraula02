import 'package:flutter/material.dart';
import 'package:flutteraula02/components/task.dart';

class TaskInherited extends InheritedWidget {
  final List<Task> taskList;
  final Function(List<Task>) updateList;

  TaskInherited({
    Key? key,
    required this.taskList,
    required this.updateList,
    required Widget child,
  }) : super(key: key, child: child);

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
    context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList != taskList;
  }
}
