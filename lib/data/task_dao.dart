import 'package:sqflite/sqflite.dart';

import '../components/task.dart';
import 'database.dart';

class TaskDao {
  static const String tableSQL =
      'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER '
      '$_photo TEXT)';

  static const _tableName = 'task_table';
  static const _name = 'name';
  static const _difficulty = 'difficulty';
  static const _photo = 'photo';

  // * Métodos auxiliares *
  List<Task> toList(List<Map<String, dynamic>> taskMap) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> row in taskMap) {
      final Task task = Task(taskName: row[_name], taskDifficulty: row[_difficulty], photoUrl: row[_photo]);
      tasks.add(task);
    }
    print('retorna lista com todas as tarefas salvas no db \n$tasks');
    return tasks;
  }

  // save(Task task) async {}
  Future<List<Task>> findAll() async {
    print('Acessando o findAll...');
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    print('Procurando dados no db... \nencontrado!');
    return toList(result);
  }

  // Future<List<Task>> find(String taskName) async {}
  // delete(String taskName) async {}
}
