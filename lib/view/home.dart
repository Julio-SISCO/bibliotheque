import 'package:bibliotheque/view/livres.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Couleur de l'app bar
        title: const Text(
          'Ma Bibliothèque',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'parametres',
                  child: Text('Paramètres'),
                ),
                const PopupMenuItem(
                  value: 'secret',
                  child: Text('Espace Privé'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: const Color.fromARGB(255, 220, 237, 251),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Ma Bibliothèque'),
                Tab(text: 'Mes Favoris'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(
                  child: LivresPage(),
                ),
                Center(
                  child: Text('Contenu de Mes Favoris'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
