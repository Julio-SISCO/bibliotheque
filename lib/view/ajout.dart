// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:bibliotheque/data/stockage.dart';
import 'package:bibliotheque/view/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bibliotheque/model/livre.dart';

class Ajout extends StatefulWidget {
  const Ajout({super.key});

  @override
  _AjoutState createState() => _AjoutState();
}

class _AjoutState extends State<Ajout> {
  final _formKey = GlobalKey<FormState>();
  String? _titre;
  String? _auteur;
  String? _annee;
  String? _editeur;
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveLivre() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final nouveauLivre = Livre(
        titre: _titre!,
        auteur: _auteur,
        annee: _annee,
        editeur: _editeur,
        couverture: _image?.path,
      );

      await Stockage.sauvegarderLivre(nouveauLivre);
      Navigator.pop(context, true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un Livre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le titre';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _titre = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Auteur'),
                onSaved: (value) {
                  setState(() {
                    _auteur = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Année'),
                onSaved: (value) {
                  setState(() {
                    _annee = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Éditeur'),
                onSaved: (value) {
                  setState(() {
                    _editeur = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              _image == null
                  ? const Text('Aucune image sélectionnée.')
                  : Image.file(_image!),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Choisir une couverture'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveLivre,
                child: const Text('Sauvegarder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
