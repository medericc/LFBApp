import 'package:flutter/material.dart';
import 'stat_screen.dart'; // Import the stats screen

class LfbScreen extends StatelessWidget {
  LfbScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('leagueId Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to StatsScreen with LFB leagueId
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen(leagueId: '1')),
                );
              },
              child: Text('LFB'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to StatsScreen with LF2 leagueId
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen(leagueId: '2')),
                );
              },
              child: Text('LF2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to StatsScreen with NF1 Poule A leagueId
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen(leagueId: '3')),
                );
              },
              child: Text('NF1 A'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to StatsScreen with NF1 Poule B leagueId
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen(leagueId: '4')),
                );
              },
              child: Text('NF1 B'),
            ),
          ],
        ),
      ),
    );
  }
}
