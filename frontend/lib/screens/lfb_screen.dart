import 'package:flutter/material.dart';
import 'stat_screen.dart'; // Import the stats screen

class LfbScreen extends StatelessWidget {
  LfbScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('League Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to StatsScreen with LFB league
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen(league: 'LFB')),
                );
              },
              child: Text('LFB'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to StatsScreen with LF2 league
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen(league: 'LF2')),
                );
              },
              child: Text('LF2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to StatsScreen with NF1 Poule A league
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen(league: 'NF1 Poule A')),
                );
              },
              child: Text('NF1 A'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to StatsScreen with NF1 Poule B league
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen(league: 'NF1 Poule B')),
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
