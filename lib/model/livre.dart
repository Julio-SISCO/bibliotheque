import 'package:hive/hive.dart';

part 'livre.g.dart';

@HiveType(typeId: 0)
class Livre extends HiveObject {
  @HiveField(0)
  late String titre;

  @HiveField(1)
  late String? auteur;

  @HiveField(2)
  late bool favori;

  @HiveField(3)
  late String? annee;

  @HiveField(4)
  late String? editeur;

  @HiveField(5)
  late List<String>? commentaires;

  @HiveField(6)
  late List<String>? notes;

  @HiveField(7)
  late String? couverture;

  Livre({
    required this.titre,
    this.auteur,
    this.annee,
    this.editeur,
    this.favori = false,
    this.commentaires,
    this.notes,
    this.couverture,
  });

  void marquerCommeFavori() {
    favori = true;
  }

  void demarquerCommeFavori() {
    favori = false;
  }

  void modifierInformations({
    String? titre,
    String? auteur,
    String? annee,
    String? editeur,
  }) {
    if (titre != null) this.titre = titre;
    if (auteur != null) this.auteur = auteur;
    if (annee != null) this.annee = annee;
    if (editeur != null) this.editeur = editeur;
  }

  void ajouterCommentaire(String commentaire) {
    commentaires ??= [];
    commentaires!.add(commentaire);
  }

  void modifierCommentaire(int index, String nouveauCommentaire) {
    if (commentaires != null && index >= 0 && index < commentaires!.length) {
      commentaires![index] = nouveauCommentaire;
    }
  }

  void prendreNote(String note) {
    notes ??= [];
    notes!.add(note);
  }

  void modifierNotePrise(int index, String nouvelleNote) {
    if (notes != null && index >= 0 && index < notes!.length) {
      notes![index] = nouvelleNote;
    }
  }

  void changerCouverture(String nouvelleCouverture) {
    couverture = nouvelleCouverture;
  }
}
