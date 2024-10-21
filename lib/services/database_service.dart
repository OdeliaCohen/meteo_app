import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_account.dart';

class DatabaseService {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'app_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE users(email TEXT PRIMARY KEY, hashedPassword TEXT, nom TEXT, age INTEGER, createdAt TEXT, deletedAt TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(UserAccount user) async {
    final Database db = await initDB();
    await db.insert(
      'users',
      {
        'email': user.email,
        'hashedPassword': user.hashedPassword,
        'nom': user.nom,
        'age': user.age,
        'createdAt': user.createdAt.toIso8601String(),
        'deletedAt': user.deletedAt?.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
