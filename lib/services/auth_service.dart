import '../models/user_account.dart';
import '../repositories/user_repository.dart';

class AuthService {
  final UserRepository userRepository;

  AuthService(this.userRepository);

  Future<bool> addUser(String email, String password, String nom, int age) async {
    // Création de l'objet utilisateur
    UserAccount user = UserAccount(
      email: email,
      hashedPassword: password, // Hacher le mot de passe avant de le stocker
      nom: nom,
      age: age,
      createdAt: DateTime.now(),
    );

    try {
      await userRepository.addUser(user);
      return true;
    } catch (e) {
      print("Erreur lors de l'ajout de l'utilisateur : $e");
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    UserAccount? user = await userRepository.getUserByEmail(email);
    if (user != null && user.hashedPassword == password) { // Remplacer par une vérification de mot de passe haché
      return true;
    }
    return false;
  }
}
