import 'package:flutteraula02/components/task.dart';
import 'package:flutteraula02/data/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  // Método para inserir tarefas iniciais
  Future<void> insertInitialTasks() async {
    final List<Task> initialTasks = [
      Task('Estudar Flutter', 'assets/images/flutter.png', 4),
      Task('Estudar Python', 'assets/images/python.png', 3),
      Task('Estudar Dart', 'assets/images/dart.png', 2),
      Task('Estudar Kotlin', 'assets/images/kotlin.png', 5),
      Task('Estudar React', 'assets/images/react.png', 3),
    ];

    for (var task in initialTasks) {
      await save(task);
    }
  }


  Future<void> addTask(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskStrings = prefs.getStringList('tasks');

    if (taskStrings == null) {
      taskStrings = [];
    }

    taskStrings.add(task.toMap().toString());
    await prefs.setStringList('tasks', taskStrings);
  }

  // Método para converter uma string de tarefa em um mapa
  Map<String, dynamic> taskStringToMap(String taskString) {
    // Lógica para converter string de volta para Map
    // Aqui você pode usar o jsonDecode se a string estiver em formato JSON
    // Exemplo: return jsonDecode(taskString);
    // Para simplificação, vamos retornar um mapa vazio por enquanto
    return {};
  }

  // Função Save
  Future<void> save(Task tarefa) async {
    print('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase(); // Sempre iniciamos o BD
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa); // O Map abaixo
    if (itemExists.isEmpty) {
      print('A Tarefa não Existia.');
      await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print('A Tarefa existia!');
      await bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.nome],
      );
    }
  }

  // Convertendo tarefa em Map
  Map<String, dynamic> toMap(Task tarefa) {
    print('Convertendo to Map: ');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    mapaDeTarefas[_image] = tarefa.foto;
    print('Mapa de Tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  // Função FINDALL
  Future<List<Task>> findAll() async {
    print('Acessando o findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
    await bancoDeDados.query(_tablename);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  // Convertendo para uma lista
  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Convertendo to List:');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(
        linha[_name],
        linha[_image],
        linha[_difficulty],
      );
      tarefas.add(tarefa);
    }
    print('Lista de Tarefas: ${tarefas.toString()}');
    return tarefas;
  }

  // Função FIND
  Future<List<Task>> find(String nomeDaTarefa) async {
    print('Acessando find: ');
    final Database bancoDeDados = await getDatabase();
    print('Procurando tarefa com o nome: ${nomeDaTarefa}');
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
    print('Tarefa encontrada: ${toList(result)}');

    return toList(result);
  }

  // Função DELETE
  Future<void> delete(String nomeDaTarefa) async {
    print('Deletando tarefa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    await bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
  }
}
