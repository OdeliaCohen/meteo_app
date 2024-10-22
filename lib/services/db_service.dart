// Importation du package mysql1
import 'package:mysql1/mysql1.dart';

class DatabaseService {
  // Configuration de la connexion
  final settings = ConnectionSettings(
    host: '34.155.138.173',
    port: 3306,
    user: 'root',
    password: ',>rbJK[8X/}oRLqe',
    db: 'ProgAv',
  );

  // Méthode pour établir la connexion
  Future<MySqlConnection> getConnection() async {
    try {
      return await MySqlConnection.connect(settings);
    } catch (e) {
      print('Erreur lors de la connexion à la base de données : $e');
      rethrow;
    }
  }

  // Exemple de méthode pour exécuter une requête
  Future<void> fetchData() async {
    var conn = await getConnection();
    try {
      var results = await conn.query('SELECT * FROM your_table');
      for (var row in results) {
        print('Données : ${row[0]}');
      }
    } finally {
      await conn.close(); // Fermer la connexion une fois terminé
    }
  }
}
