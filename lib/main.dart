import 'package:flutter/material.dart';
import 'views/home_view.dart';  // Importe la nouvelle vue d'accueil

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Alert App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),  // Définit HomeView comme la vue principale au démarrage
    );
  }
}
