import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  final String league; // The league passed from the previous screen

  TeamScreen({required this.league});

  // Dummy list of team names (replace with real team names if available)
  final List<String> teams = [
    'Team 1',
    'Team 2',
    'Team 3',
    'Team 4',
    'Team 5',
    'Team 6',
    'Team 7',
    'Team 8',
    'Team 9',
    'Team 10',
    'Team 11',
    'Team 12',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$league Teams'), // Show the selected league name
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns (6 buttons on the left, 6 on the right)
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: teams.length, // 12 teams
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () {
                // Handle button press for team selection (can navigate to another screen or show team details)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected ${teams[index]}')),
                );
              },
              child: Text(teams[index]), // Display team name
            );
          },
        ),
      ),
    );
  }
}
