import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //数据库名
  static const String _DB_NAME = "";

  //数据库版本号
  static const int _DB_VERSION = 1;

  /*操作数据库对象*/
  Database _database;

  /*私有*/
  DatabaseHelper._();

  /*数据库操作帮助类*/
  static final DatabaseHelper mDatabaseHelper = DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await init();
    return _database;
  }

  /*初始化数据库,并返回数据库对象*/
  init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _DB_NAME);
    print(path);

    return await openDatabase(path,
        version: _DB_VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  /*创建数据库表*/
  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
  }

  /*数据库版本升级*/
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("oldVersion:$oldVersion;newVersion:$newVersion");
  }
}
