import 'package:sqflite/sqflite.dart';
import 'dart:async';

import '../components/task.dart';
import 'database.dart';

class TaskDao {
  static final TaskDao _instance = TaskDao._internal();

  factory TaskDao() => _instance;

  TaskDao._internal();

  final StreamController<List<Task>> _taskStreamController =
      StreamController.broadcast();

  static const String tableSQL =
      '''CREATE TABLE $_tableName(
      $_name TEXT, 
      $_difficulty INTEGER, 
      $_photo TEXT,
      $_level INTEGER)''';

  static const _tableName = 'task_table';
  static const _name = 'name';
  static const _difficulty = 'difficulty';
  static const _photo = 'photo';
  static const _level = 'level';

  // * Métodos auxiliares *
  List<Task> toList(List<Map<String, dynamic>> taskMap) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> row in taskMap) {
      final Task task = Task(
        taskName: row[_name],
        taskDifficulty: row[_difficulty],
        photoUrl: row[_photo],
        level: row[_level],
      );
      tasks.add(task);
    }
    print('retorna lista com todas as tarefas salvas no db \n$tasks');
    return tasks;
  }

  Map<String, dynamic> toMap(Task task) {
    final Map<String, dynamic> taskMap = {}; // Map(); Por que não?:
    taskMap[_name] = task.taskName;
    taskMap[_difficulty] = task.taskDifficulty;
    taskMap[_photo] = task.photoUrl;
    taskMap[_level] = task.level;
    return taskMap;
  }

  Future<void> _refreshTasks() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    final List<Task> tasks = toList(result);
    _taskStreamController.add(tasks); // envia os dados pro stream
  }

  Stream<List<Task>> watchAll() {
    _refreshTasks(); // força a primeira emissão
    return _taskStreamController.stream;
  }

  void dispose() {
    _taskStreamController.close();
  }

  update(Task task) async {
    print(" Método update ");
    final Database db = await getDatabase();
    var  taskMap = toMap(task);
    await db.update(
      _tableName,
      taskMap,
      where: '$_name = ?',
      whereArgs: [task.taskName],
    );
    _refreshTasks();
  }

  save(Task task) async {
    print(" Método save ");
    final Database db = await getDatabase();
    var  taskMap = toMap(task);
    var itemList = await find(task.taskName);
    print('Resultado de find("${task.taskName}"): $itemList');
    if (itemList.isEmpty) {
      print(" A tarefa não existia  ");
      await db.insert(_tableName, taskMap);
    } else {
      await db.update(
        _tableName,
        taskMap,
        where: '$_name = ?',
        whereArgs: [task.taskName],
      );
    }
    _refreshTasks();
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return toList(result);
  }

  Future<List<Task>> find(String taskName) async {
    print(" Acesando find:  ");
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: '$_name = ?',
      whereArgs: [taskName],
    );
    return toList(result);
  }

  delete(String taskName) async {
    final Database db = await getDatabase();
     await db.delete(_tableName, where: '$_name = ?',whereArgs: [taskName]);
    _refreshTasks();
  }

}
