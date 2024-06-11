// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:bibliotheque/data/stockage.dart';
import 'package:bibliotheque/view/ajout.dart';
import 'package:flutter/material.dart';

class LivresPage extends StatefulWidget {
  const LivresPage({super.key});

  @override
  _LivresPageState createState() => _LivresPageState();
}

class _LivresPageState extends State<LivresPage> {
  late Future<List<dynamic>> _livresFuture;

  @override
  void initState() {
    super.initState();
    _livresFuture = Stockage.recupererLivres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _livresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child:
                    Text('Erreur de chargement des livres. ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Aucun livre dans votre bibliothèque.'),
            );
          } else {
            final livres = snapshot.data!;
            return ListView.builder(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                final livre = livres[index];
                return ListTile(
                  leading: livre.couverture != null
                      ? Image.file(File(livre.couverture!))
                      : const Icon(Icons.book),
                  title: Text(livre.titre),
                  subtitle: Text(livre.auteur ?? 'Auteur inconnu'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await Stockage.supprimerLivre(index);
                      setState(() {
                        _livresFuture = Stockage.recupererLivres();
                      });
                    },
                  ),
                  onTap: () {
                    // Ajoutez la logique de navigation ici si nécessaire.
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Ajout()),
          );

          if (result == true) {
            setState(() {
              _livresFuture = Stockage.recupererLivres();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
