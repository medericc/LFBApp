import 'package:flutter/material.dart';
import 'dart:convert'; // Pour décoder les réponses JSON
import 'package:http/http.dart' as http; // Pour les requêtes HTTP

class TeamScreen extends StatefulWidget {
  final String leagueId;
   final String name; // ID de la ligue passé depuis l'écran précédent

  TeamScreen({required this.leagueId, required this.name});

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  List<String> teams = []; // Liste des équipes à afficher
  bool isLoading = true; // Pour indiquer que les données sont en cours de chargement

  @override
  void initState() {
    super.initState();
    fetchTeams(); // Appeler la méthode pour récupérer les équipes quand l'écran est chargé
  }

  // Méthode pour récupérer les équipes depuis le backend
  Future<void> fetchTeams() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/leagues/${widget.leagueId}/teams'));

      if (response.statusCode == 200) {
        print('Response data: ${response.body}'); // Affiche la réponse dans la console
        setState(() {
          teams = List<String>.from(json.decode(response.body).map((team) => team['name']));
          isLoading = false;
        });
      } else {
        print('Erreur avec le statut : ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement des équipes')),
        );
      }
    } catch (e) {
      print('Fetching teams for league ID: ${widget.leagueId}');

      print('Erreur : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur réseau')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Équipes de la Ligue ${widget.name}'), // Afficher le nom de la ligue
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Afficher un indicateur de chargement pendant que les données sont récupérées
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Deux colonnes
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: teams.length, // Nombre d'équipes à afficher
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 150, // Largeur fixée des boutons
                    height: 50, // Hauteur fixée des boutons
                    child: ElevatedButton(
                      onPressed: () {
                        // Action lors de la sélection d'une équipe
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Équipe sélectionnée : ${teams[index]}')),
                        );
                      },
                      child: Text(
                        teams[index],
                        style: TextStyle(fontSize: 14), // Ajuster la taille du texte si besoin
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Réduire les marges intérieures
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
