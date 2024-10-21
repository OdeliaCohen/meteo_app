import 'package:flutter/material.dart';
import 'user_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Alert App'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        width: double.infinity, // Assure que le conteneur prend toute la largeur disponible
        height: double.infinity, // Assure que le conteneur prend toute la hauteur disponible
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/weather_background.jpg'),
            fit: BoxFit.cover, // Assure que l'image couvre tout l'écran
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenue sur Weather Alert App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Créer un compte / Connexion'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Ajoute ici d'autres actions si nécessaire
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: const Text('Découvrir les fonctionnalités'),
            ),
          ],
        ),
      ),
    );
  }
}
