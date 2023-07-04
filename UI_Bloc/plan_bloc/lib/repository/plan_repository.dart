//Todo: PlanRepository
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PlanRepository {
  static const planTable = 'helo';

  //*InitData
  //Todo:
  static Future<Database> createDB() async {
    final dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'todo.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE IF NOT EXISTS $planTable(planId INTEGER PRIMARY KEY AUTOINCREMENT,"
          "planTask STRING NOT NULL,"
          "planDescription STRING NOT NULL,"
          "planDate STRING NOT NULL,"
          "planCompleted BOOLEAN)",
        );
      },
      version: 1,
    );
  }

  //Todo: SelectAll
  static Future<List<Map<String, dynamic>>> selectAll(String table) async {
    final database = await PlanRepository.createDB();

    return database.query(table);
  }

  //Todo: InsertData
  static Future insert(String table, Map<String, dynamic> data) async {
    final database = await PlanRepository.createDB();

    return database.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Todo: UpdateTodo
  static Future update(
    String tableName,
    String columnName,
    String value,
    int id,
  ) async {
    final database = await PlanRepository.createDB();

    return database.update(
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
    final database = await PlanRepository.createDB();

    return database.delete(
      tableName,
      where: '$columnName = ?',
      whereArgs: [id],
    );
  }

  //Todo: deleteData
  static Future deleteTable(String tableName) async {
    final database = await PlanRepository.createDB();

    return database.rawDelete('DELETE FROM $tableName');
  }
}
