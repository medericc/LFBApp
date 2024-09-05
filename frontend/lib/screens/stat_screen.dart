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
  // Booleans for controlling expanded panels
  bool _isPointsExpanded = false;
  bool _isAssistsExpanded = false;
  bool _isReboundsExpanded = false;
  bool _isStealsExpanded = false;
  bool _isBlocksExpanded = false;
  bool _isEffExpanded = false;
  bool _is3pExpanded = false;
  bool _isLfExpanded = false;

  // Dynamic data for top players for each stat
  List<String> topPointsPlayers = [];
  List<String> topAssistsPlayers = [];
  List<String> topReboundsPlayers = [];
  List<String> topStealsPlayers = [];
  List<String> topBlocksPlayers = [];
  List<String> topEffPlayers = [];
  List<String> top3pPlayers = [];
  List<String> topLfPlayers = [];

  @override
  void initState() {
    super.initState();
    fetchTopPlayers('points', (players) => setState(() => topPointsPlayers = players));
    fetchTopPlayers('assists', (players) => setState(() => topAssistsPlayers = players));
    fetchTopPlayers('rebonds', (players) => setState(() => topReboundsPlayers = players));
    fetchTopPlayers('steals', (players) => setState(() => topStealsPlayers = players));
    fetchTopPlayers('blocks', (players) => setState(() => topBlocksPlayers = players));
    fetchTopPlayers('evaluation', (players) => setState(() => topEffPlayers = players));
    fetchTopPlayers('three_points', (players) => setState(() => top3pPlayers = players));
    fetchTopPlayers('lancers', (players) => setState(() => topLfPlayers = players));
  }

  Future<void> fetchTopPlayers(String stat, Function(List<String>) onPlayersLoaded) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/${widget.leagueId}/top-players/$stat')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        onPlayersLoaded(data.map((player) => '${player['forename']} ${player['name']}').toList());
      } else {
        throw Exception('Erreur lors de la récupération des joueurs');
      }
    } catch (error) {
      print('Erreur: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des joueurs pour $stat')),
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
            _buildStatBar('Assists', topAssistsPlayers, _isAssistsExpanded, () {
              setState(() {
                _isAssistsExpanded = !_isAssistsExpanded;
              });
            }),
            _buildStatBar('Rebounds', topReboundsPlayers, _isReboundsExpanded, () {
              setState(() {
                _isReboundsExpanded = !_isReboundsExpanded;
              });
            }),
            _buildStatBar('Steals', topStealsPlayers, _isStealsExpanded, () {
              setState(() {
                _isStealsExpanded = !_isStealsExpanded;
              });
            }),
            _buildStatBar('Blocks', topBlocksPlayers, _isBlocksExpanded, () {
              setState(() {
                _isBlocksExpanded = !_isBlocksExpanded;
              });
            }),
            _buildStatBar('Efficiency', topEffPlayers, _isEffExpanded, () {
              setState(() {
                _isEffExpanded = !_isEffExpanded;
              });
            }),
            _buildStatBar('3 Points', top3pPlayers, _is3pExpanded, () {
              setState(() {
                _is3pExpanded = !_is3pExpanded;
              });
            }),
            _buildStatBar('Lancer-Franc', topLfPlayers, _isLfExpanded, () {
              setState(() {
                _isLfExpanded = !_isLfExpanded;
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
