import 'package:flutter/material.dart';
import 'team_screen.dart'; // Import the TeamScreen

class NatScreen extends StatelessWidget {
  NatScreen({Key? key}) : super(key: key);

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
                // Navigate to TeamScreen with LFB league
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamScreen(league: 'LFB')),
                );
              },
              child: Text('LFB'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to TeamScreen with LF2 league
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamScreen(league: 'LF2')),
                );
              },
              child: Text('LF2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to TeamScreen with NF1 Poule A league
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamScreen(league: 'NF1 Poule A')),
                );
              },
              child: Text('NF1 A'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to TeamScreen with NF1 Poule B league
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamScreen(league: 'NF1 Poule B')),
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
