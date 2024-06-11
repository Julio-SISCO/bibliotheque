import 'package:bibliotheque/model/livre.dart';
import 'package:hive/hive.dart';

class Stockage {
  static const String _motDePasseBox = 'motDePasseBox';
  static const String _livresBox = 'livresBox';
  static const String _secretBox = 'secretBox';

  // Sauvegarde des données d'un livre
  static Future<void> sauvegarderLivre(Livre livre) async {
    final box = await Hive.openBox<Livre>(_livresBox);
    await box.add(livre);
    await box.close();
  }

  // Sauvegarde des données d'un livre secret
  static Future<void> sauvegarderLivreSecret(Livre livre) async {
    final box = await Hive.openBox<Livre>(_secretBox);
    await box.add(livre);
    await box.close();
  }

  // Récupération de tous les livres
  static Future<List<dynamic>> recupererLivres() async {
    final box = await Hive.openBox<dynamic>(_livresBox);
    final livres = box.values.toList();
    await box.close();
    return livres;
  }

  // Récupération de tous les livres secrets
  static Future<List<Livre>> recupererLivresSecrets() async {
    final box = await Hive.openBox<Livre>(_secretBox);
    final livres = box.values.toList();
    await box.close();
    return livres;
  }

  // Suppression d'un livre
  static Future<void> supprimerLivre(int index) async {
    final box = await Hive.openBox<Livre>(_livresBox);
    await box.deleteAt(index);
    await box.close();
  }

  // Suppression de tous les livres
  static Future<void> supprimerTousLesLivres() async {
    final box = await Hive.openBox<Livre>(_livresBox);
    await box.clear();
    await box.close();
  }

  // Suppression d'un livre secret
  static Future<void> supprimerLivreSecret(int index) async {
    final box = await Hive.openBox<Livre>(_secretBox);
    await box.deleteAt(index);
    await box.close();
  }

  // Mise à jour d'un livre
  static Future<void> mettreAJourLivre(int index, Livre nouveauLivre) async {
    final box = await Hive.openBox<Livre>(_livresBox);
    await box.putAt(index, nouveauLivre);
    await box.close();
  }

  // Changement de mot de passe
  static Future<void> changerMotDePasse(String nouveauMotDePasse) async {
    final box = await Hive.openBox<String>(_motDePasseBox);
    await box.put('motDePasse', nouveauMotDePasse);
    await box.close();
  }

  // Récupération du mot de passe
  static Future<String?> recupererMotDePasse() async {
    final box = await Hive.openBox<String>(_motDePasseBox);
    final motDePasse = box.get('motDePasse');
    await box.close();
    return motDePasse;
  }
}
