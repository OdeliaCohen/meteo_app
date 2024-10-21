import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../repositories/user_repository.dart';

class UserView extends StatefulWidget {
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final AuthService authService = AuthService(UserRepository());

  // Enregistrement de l'utilisateur
  Future<void> _registerUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    int? age = int.tryParse(ageController.text.trim());

    // Validation des champs de texte
    if (email.isEmpty || password.isEmpty || name.isEmpty || age == null || age <= 0) {
      _showMessage("Please fill all fields correctly.");
      return;
    }

    // Enregistrement asynchrone
    bool success = await authService.addUser(email, password, name, age);
    if (success) {
      _showMessage("User registered successfully");
      _clearFields();
    } else {
      _showMessage("Registration failed. Please try again.");
    }
  }

  // Connexion de l'utilisateur
  Future<void> _loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please enter both email and password.");
      return;
    }

    bool success = await authService.login(email, password);
    if (success) {
      _showMessage("Login successful");
      _clearFields();
    } else {
      _showMessage("Login failed. Invalid email or password.");
    }
  }

  // Affichage des messages avec SnackBar
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Nettoyage des champs de texte
  void _clearFields() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _registerUser,
                  child: Text("Register"),
                ),
                ElevatedButton(
                  onPressed: _loginUser,
                  child: Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
