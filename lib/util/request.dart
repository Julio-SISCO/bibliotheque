import 'package:bibliotheque/data/stockage.dart';

class Request {
  static Future<void> passerEnLivreSecret(int index) async {
    // Récupérer tous les livres
    final livres = await Stockage.recupererLivres();
    if (index >= 0 && index < livres.length) {
      // Récupérer le livre à déplacer en secret
      final livre = livres[index];

      // Supprimer le livre de la liste des livres simples
      await Stockage.supprimerLivre(index);

      // Sauvegarder le livre dans la liste des livres secrets
      await Stockage.sauvegarderLivreSecret(livre);
    }
  }

  static Future<void> passerEnLivreSimple(int index) async {
    // Récupérer tous les livres secrets
    final livresSecrets = await Stockage.recupererLivresSecrets();
    if (index >= 0 && index < livresSecrets.length) {
      // Récupérer le livre à déplacer en simple
      final livre = livresSecrets[index];

      // Supprimer le livre de la liste des livres secrets
      await Stockage.supprimerLivreSecret(index);

      // Sauvegarder le livre dans la liste des livres simples
      await Stockage.sauvegarderLivre(livre);
    }
  }
}
