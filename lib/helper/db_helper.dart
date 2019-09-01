import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {

  static Future<sql.Database> datable() async{
    final dbPath = await sql.getDatabasesPath();

    return await sql.openDatabase(path.join(dbPath,'places.db'),onCreate: (db,version){
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT,imagePath TEXT, loc_lat REAL,loc_lng REAL, address TEXT)');
    },version: 1);

  }

  static Future<void> insert(String table,Map<String,dynamic> data) async{
    final db = await DBHelper.datable();

    await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>> getData(String table) async{
    final db = await DBHelper.datable();
    return await db.query(table);
  }

  static Future<void> deleteTable(String table) async{
    final db = await DBHelper.datable();
    await db.execute('DELETE FROM ${table}');
  }
}