import 'package:flutter/material.dart';
import 'services/db_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DatabaseService dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart MySQL Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Connexion MySQL avec Dart'),
        ),
        body: Center(
          child: FutureBuilder(
            future: dbService.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur : ${snapshot.error}');
              } else {
                return Text('Données récupérées avec succès !');
              }
            },
          ),
        ),
      ),
    );
  }
}
