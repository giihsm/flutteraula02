import 'package:flutter/material.dart';
import 'package:flutteraula02/screens/form_screen.dart';
import 'package:flutteraula02/data/task_inherited.dart';
import '../components/task.dart';
import '../components/task_widget.dart';
import '../data/task_dao.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  List<Task> _tasks = [];
  bool _isLoading = true; // Variável para controlar o estado de carregamento

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTasks();
    });
  }

  void _loadTasks() async {
    setState(() {
      _isLoading = true; // Inicia o carregamento
    });

    TaskDao taskDao = TaskDao();
    List<Task> tasks = await taskDao.findAll();

    // Log para verificar quantas tarefas foram carregadas
    print('Tarefas carregadas: ${tasks.length}');

    if (tasks.isEmpty) {
      await taskDao.insertInitialTasks();
      tasks = await taskDao.findAll();
      print('Tarefas iniciais inseridas.');
    }

    _updateTaskList(tasks);
    setState(() {
      _isLoading = false; // Finaliza o carregamento
    });
  }

  void _updateTaskList(List<Task> tasks) {
    setState(() {
      _tasks = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TaskInherited(
      taskList: _tasks,
      updateList: _updateTaskList,
      child: Scaffold(
        appBar: AppBar(title: const Text('Lista de Tarefas')),
        body: _isLoading
            ? Center(child: CircularProgressIndicator()) // Mostra um indicador de carregamento
            : ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            return TaskWidget(task: _tasks[index]);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FormScreen(taskContext: context),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
