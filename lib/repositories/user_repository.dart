import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_account.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  Database? _database;

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();

  // Initialisation de la base de données
  Future<Database> _initDB() async {
    if (_database != null) return _database!;
    
    String path = await getDatabasesPath();
    String dbPath = join(path, 'app_database.db');
    
    _database = await openDatabase(
      dbPath,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            email TEXT PRIMARY KEY,
            hashedPassword TEXT,
            nom TEXT,
            age INTEGER,
            createdAt TEXT,
            deletedAt TEXT
          )
        ''');
      },
      version: 1,
    );
    
    return _database!;
  }

  // Insertion d'un nouvel utilisateur
  Future<void> addUser(UserAccount user) async {
    final db = await _initDB();
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

  // Récupération d'un utilisateur par email
  Future<UserAccount?> getUserByEmail(String email) async {
    final db = await _initDB();
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return UserAccount(
        email: result[0]['email'],
        hashedPassword: result[0]['hashedPassword'],
        nom: result[0]['nom'],
        age: result[0]['age'],
        createdAt: DateTime.parse(result[0]['createdAt']),
        deletedAt: result[0]['deletedAt'] != null ? DateTime.parse(result[0]['deletedAt']) : null,
      );
    }
    return null;
  }

  // Mise à jour des informations d'un utilisateur
  Future<void> updateUser(UserAccount user) async {
    final db = await _initDB();
    await db.update(
      'users',
      {
        'hashedPassword': user.hashedPassword,
        'nom': user.nom,
        'age': user.age,
        'createdAt': user.createdAt.toIso8601String(),
        'deletedAt': user.deletedAt?.toIso8601String(),
      },
      where: 'email = ?',
      whereArgs: [user.email],
    );
  }

  // Suppression d'un utilisateur par email
  Future<void> deleteUser(String email) async {
    final db = await _initDB();
    await db.delete(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  // Fermeture de la base de données
  Future<void> close() async {
    final db = await _initDB();
    db.close();
  }
}
