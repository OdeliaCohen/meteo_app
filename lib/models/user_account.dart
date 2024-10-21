class UserAccount {
  final String email;
  final String hashedPassword;
  final String nom;
  final int age;
  final DateTime createdAt;
  DateTime? deletedAt;

  UserAccount({
    required this.email,
    required this.hashedPassword,
    required this.nom,
    required this.age,
    required this.createdAt,
    this.deletedAt,
  });

  void createAccount() {
    // Logique pour créer un compte utilisateur
  }

  void deleteAccount() {
    // Logique pour supprimer le compte utilisateur
    deletedAt = DateTime.now();
  }

  bool signIn(String password) {
    // Logique pour authentifier un utilisateur
    return hashedPassword == password; // Simplifié pour l'exemple
  }
}
