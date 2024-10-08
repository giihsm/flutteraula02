import 'package:flutter/material.dart';
import 'package:flutteraula02/components/task.dart';
import 'package:flutteraula02/data/task_dao.dart';
import 'package:flutteraula02/data/task_inherited.dart';

class FormScreen extends StatelessWidget {
  final BuildContext taskContext;

  FormScreen({Key? key, required this.taskContext}) : super(key: key);

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dificuldadeController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();

  void _addTask() async {
    final String nome = _nomeController.text;
    final String dificuldadeText = _dificuldadeController.text;
    final String foto = _fotoController.text;

    if (nome.isNotEmpty && dificuldadeText.isNotEmpty) {
      int? dificuldade = int.tryParse(dificuldadeText);
      if (dificuldade != null) {
        final Uri? uri = Uri.tryParse(foto);
        if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
          Task newTask = Task(nome, foto, dificuldade);

          // Adiciona a tarefa ao banco de dados
          TaskDao taskDao = TaskDao();
          await taskDao.addTask(newTask);  // Chame o método para adicionar a tarefa

          // Atualiza a lista de tarefas no TaskInherited
          final taskInherited = TaskInherited.of(taskContext);
          taskInherited.updateList([...taskInherited.taskList, newTask]);

          Navigator.pop(taskContext);  // Fecha a tela de formulário
        } else {
          ScaffoldMessenger.of(taskContext).showSnackBar(
            SnackBar(content: Text('URL da foto deve ser válida.')),
          );
        }
      } else {
        ScaffoldMessenger.of(taskContext).showSnackBar(
          SnackBar(content: Text('Dificuldade deve ser um número válido.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome da Tarefa'),
            ),
            TextField(
              controller: _dificuldadeController,
              decoration: const InputDecoration(labelText: 'Dificuldade (número)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _fotoController,
              decoration: const InputDecoration(labelText: 'URL da Foto'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Adicionar Tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}
