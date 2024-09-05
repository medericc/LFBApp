import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatsScreen extends StatefulWidget {
  final String leagueId; // Pass the leagueId name to this screen

  StatsScreen({required this.leagueId});

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // This will store which bar is expanded
  bool _isPointsExpanded = false;
  
  // Dynamic data for top players
  List<String> topPointsPlayers = [];

  @override
  void initState() {
    super.initState();
    fetchTopPlayers(); // Fetch data when the screen is initialized
  }

  Future<void> fetchTopPlayers() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/${widget.leagueId}/top-players/points')
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        setState(() {
          topPointsPlayers = data.map((player) => '${player['forename']} ${player['name']}').toList();
        });
      } else {
        throw Exception('Erreur lors de la récupération des joueurs');
      }
    } catch (error) {
      print('Erreur: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des joueurs')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.leagueId} Stats'), // Show the selected leagueId
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildStatBar('Points', topPointsPlayers, _isPointsExpanded, () {
              setState(() {
                _isPointsExpanded = !_isPointsExpanded;
              });
            }),
          ],
        ),
      ),
    );
  }

  // Function to build each stat bar with a toggle for dropdown
  Widget _buildStatBar(String statName, List<String> players, bool isExpanded, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          title: Text(statName),
          trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          onTap: onTap,
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: players
                  .map((player) => ListTile(
                        title: Text(player),
                      ))
                  .toList(),
            ),
          ),
        Divider(),
      ],
    );
  }
}
