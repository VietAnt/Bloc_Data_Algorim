// ignore_for_file: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Todo: Database
class DBHelper {
  static const todoTable = 'todo';

  //Todo:
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'todo.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE IF NOT EXISTS $todoTable(id TEXT PRIMARY KEY,"
          " title TEXT,"
          " description TEXT,"
          " date TEXT)",
        );
      },
      version: 1,
    );
  }

  //Todo: selectAll
  static Future<List<Map<String, dynamic>>> selectAll(String table) async {
    final db = await DBHelper.database();

    return db.query(table);
  }

  //Todo: insertData
  static Future insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    return db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Todo: UpdateData
  static Future update(
    String tableName,
    String columnName,
    String value,
    String id,
  ) async {
    final db = await DBHelper.database();

    return db.update(
      tableName,
      {columnName: value},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Todo: deleteByID
  static Future deleteById(
    String tableName,
    String columnName,
    String id,
  ) async {
    final db = await DBHelper.database();

    return db.delete(
      tableName,
      where: '$columnName = ?',
      whereArgs: [id],
    );
  }

  //Todo: deleteData
  static Future deleteTable(String tableName) async {
    final db = await DBHelper.database();

    return db.rawDelete('DELETE FROM $tableName');
  }
}
