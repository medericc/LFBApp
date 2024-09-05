import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  final String league; // Pass the league name to this screen

  StatsScreen({required this.league});

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // This will store which bar is expanded
  bool _isPointsExpanded = false;
  bool _isAssistsExpanded = false;
  bool _isReboundsExpanded = false;
  bool _isStealsExpanded = false;
  bool _isBlocksExpanded = false;
  bool _isEffExpanded = false;
  bool _is3pExpanded = false;
  bool _isLfExpanded = false;

  // Dummy data for top 5 players for each stat (You can replace this with real data from your backend)
  List<String> topPointsPlayers = ['Player 1', 'Player 2', 'Player 3', 'Player 4', 'Player 5'];
  List<String> topAssistsPlayers = ['Player A', 'Player B', 'Player C', 'Player D', 'Player E'];
  List<String> topReboundsPlayers = ['Player X', 'Player Y', 'Player Z', 'Player Q', 'Player W'];
  List<String> topStealsPlayers = ['Player M', 'Player N', 'Player O', 'Player P', 'Player R'];
  List<String> topBlocksPlayers = ['Player F', 'Player G', 'Player H', 'Player I', 'Player J'];
  List<String> topEffPlayers = ['Player F', 'Player G', 'Player H', 'Player I', 'Player J'];
  List<String> top3pPlayers = ['Player F', 'Player G', 'Player H', 'Player I', 'Player J'];
  List<String> topLfPlayers = ['Player F', 'Player G', 'Player H', 'Player I', 'Player J'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.league} Stats'), // Show the selected league
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
