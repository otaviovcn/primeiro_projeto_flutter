class TaskDao {
  static const String tableSQL =
      'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER '
      '$_image TEXT)';

  static const _tableName = 'taskTable';
  static const _name = 'name';
  static const _difficulty = 'difficulty';
  static const _image = 'image';
}
