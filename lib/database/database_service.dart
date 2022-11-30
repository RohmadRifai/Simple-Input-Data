import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $table (
  ${Fields.id} $idType,
  ${Fields.nama} $textType,
  ${Fields.alamat} $textType
  )
''');
  }

  Future<bool> checkData(Data data, Database database) async {
    final result = await database.query(table,
        columns: Fields.values,
        where: '${Fields.nama} LIKE ? AND ${Fields.alamat} LIKE ?',
        whereArgs: ['%${data.nama}%', '%${data.alamat}%']);

    if (result.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createData(Data data) async {
    final db = await instance.database;

    final check = await checkData(data, db);
    if (!check) {
      return;
    }

    await db.insert(table, data.toJson());
  }

  Future<List<Data>> readDatas() async {
    final db = await instance.database;

    final result = await db.query(table, orderBy: '${Fields.nama} ASC');

    return result.map((json) => Data.fromJson(json)).toList();
  }
}
