import 'package:flutteraula02/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');
  return openDatabase(path, onCreate: (db, version) async {
    try {
      await db.execute(TaskDao.tableSql);
      print('Tabela criada com sucesso');
    } catch (e) {
      print('Erro ao criar a tabela: $e');
    }
  }, version: 1);
}