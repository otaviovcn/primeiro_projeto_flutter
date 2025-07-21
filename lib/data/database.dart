import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDtabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');
  return openDatabase(path, onCreate: (db, version){
    db.execute(tableSQL);
  }, version: 1);
}

const String tableSQL = 'CREATE TABLE $_tablename('
    '$_name TEXT, '
    '$_difficulty INTEGER '
    '$_image TEXT)';

const _tablename = 'taskTable';
const _name = 'name';
const _difficulty = 'difficulty';
const _image = 'image';