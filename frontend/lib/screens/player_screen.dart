import 'package:flutter/material.dart';
import 'dart:convert'; // Pour décoder les réponses JSON
import 'package:http/http.dart' as http; // Pour les requêtes HTTP

class Player {
  final String name;
  final String forename;
  final int points;
  final int assists;
  final int rebonds;
  final int steals;
  final int blocks;
  final int evaluation;
  final int threePoints;
  final int lancers;
  final int teamId;

  Player({
    required this.name,
    required this.forename,
    required this.points,
    required this.assists,
    required this.rebonds,
    required this.steals,
    required this.blocks,
    required this.evaluation,
    required this.threePoints,
    required this.lancers,
    required this.teamId,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json'); // Pour déboguer

    return Player(
      name: json['name'] ?? '',
      forename: json['forename'] ?? '',
      points: json['points'] is int ? json['points'] : 0,
      assists: json['assists'] is int ? json['assists'] : 0,
      rebonds: json['rebonds'] is int ? json['rebonds'] : 0,
      steals: json['steals'] is int ? json['steals'] : 0,
      blocks: json['blocks'] is int ? json['blocks'] : 0,
      evaluation: json['evaluation'] is int ? json['evaluation'] : 0,
      threePoints: json['three_points'] is int ? json['three_points'] : 0,
      lancers: json['lancers'] is int ? json['lancers'] : 0,
      teamId: json['team_id'] is int ? json['team_id'] : 0,
    );
  }
}

class PlayerScreen extends StatefulWidget {
  final String teamId; // ID de l'équipe passé depuis l'écran précédent

  PlayerScreen({required this.teamId});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  List<Player> players = []; // Liste des joueurs à afficher
  bool isLoading = true; // Indicateur de chargement
  Map<int, bool> _expandedPlayers = {}; // Stocke l'état d'expansion pour chaque joueur

  @override
  void initState() {
    super.initState();
    fetchPlayers(); // Appel de la méthode pour récupérer les joueurs au chargement
  }

  // Méthode pour récupérer les joueurs depuis le backend
  Future<void> fetchPlayers() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/teams/${widget.teamId}/players'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print('Raw JSON Data: $jsonData'); // Pour déboguer

        setState(() {
          players = jsonData.map((data) {
            try {
              return Player.fromJson(data);
            } catch (e) {
              print('Error parsing player data: $e');
              return null; // Assurez-vous de gérer les joueurs invalides
            }
          }).whereType<Player>().toList();
          isLoading = false;
        });
      } else {
        print('Erreur serveur: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement des joueurs: ${response.body}')),
        );
      }
    } catch (e) {
      print('Erreur réseau: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur réseau: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joueurs de l\'équipe ${widget.teamId}'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Indicateur de chargement
          : ListView.builder(
              itemCount: players.length, // Nombre de joueurs à afficher
              itemBuilder: (context, index) {
                final player = players[index];
                final isExpanded = _expandedPlayers[index] ?? false; // Vérifier si ce joueur est expansé

                return _buildPlayerTile(
                  player,
                  isExpanded,
                  () {
                    setState(() {
                      _expandedPlayers[index] = !isExpanded; // Toggle l'état d'expansion
                    });
                  },
                );
              },
            ),
    );
  }

  // Fonction pour construire chaque ligne de joueur avec un menu déroulant
  Widget _buildPlayerTile(Player player, bool isExpanded, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          title: Text('${player.forename} ${player.name}'),
          trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          onTap: onTap,
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildStatRow('Points', player.points),
                _buildStatRow('Assists', player.assists),
                _buildStatRow('Rebonds', player.rebonds),
                _buildStatRow('Steals', player.steals),
                _buildStatRow('Blocks', player.blocks),
                _buildStatRow('Evaluation', player.evaluation),
                _buildStatRow('3 Points', player.threePoints),
                _buildStatRow('Lancers Francs', player.lancers),
              ],
            ),
          ),
        Divider(), // Ligne de séparation
      ],
    );
  }

  // Widget pour afficher une ligne de statistique avec un nom et une valeur
  Widget _buildStatRow(String statName, int statValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(statName),
        Text(statValue.toString()),
      ],
    );
  }
}
