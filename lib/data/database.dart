import 'package:nosso_primeiro_projeto/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  // deleteDatabase(join(await getDatabasesPath(), 'task.db'));
  final String path = join(await getDatabasesPath(), 'task.db');
  return openDatabase(path, onCreate: (db, version){
    db.execute(TaskDao.tableSQL);
  }, version: 1);
}
