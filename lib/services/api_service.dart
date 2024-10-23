import 'dart:convert';
import 'package:http/http.dart' as http;

// Fonction pour ajouter un utilisateur
Future<void> addUser(String username, String email, String password) async {
  final url = Uri.parse('https://apisql-439420.oa.r.appspot.com/create_user');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    print('Utilisateur ajouté avec succès.');
  } else {
    throw Exception('Erreur lors de l\'ajout de l\'utilisateur.');
  }
}

// Fonction pour récupérer la liste des utilisateurs
Future<List<dynamic>> getUsers() async {
  final url = Uri.parse('https://apisql-439420.oa.r.appspot.com/get_users');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Erreur lors de la récupération des utilisateurs.');
  }
}
