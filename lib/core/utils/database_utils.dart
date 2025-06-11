import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseUtils{

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        middleName TEXT,
        lastName TEXT,
        phoneNumber TEXT,
        countryCode TEXT,
        isFavourite INTEGER,
        email TEXT,
        image TEXT,
        company TEXT
      )
    ''');
  }

  Future<void> closeDB()async {
    if(_database!=null){
      await _database!.close();
    }
  }
}