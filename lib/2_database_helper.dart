import 'package:uts/1_onlineshop_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  final String tableName = 'tableOnlineShop';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnDescription = 'description';
  final String columnRating = 'rating';
  final String columnPassword = 'password';

  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initializeDb();
    return _database;
  }

  Future<Database?> _initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'onlineshop_db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var phpmyadmin = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnDescription TEXT,"
        "$columnRating TEXT,"
        "$columnPassword TEXT)";
    await db.execute(phpmyadmin);
  }

  Future<int?> saveOnlineShop(OnlineShopModel onlineshop) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, onlineshop.toMap());
  }

  Future<List?> getAllOnlineShop() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnDescription,
      columnRating,
      columnPassword
    ]);
    return result.toList();
  }

  Future<int?> updateOnlineShop(OnlineShopModel onlineshop) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, onlineshop.toMap(),
        where: '$columnId = ?', whereArgs: [onlineshop.id]);
  }

  Future<int?> deleteOnlineShop(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
