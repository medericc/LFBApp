import 'package:flutter/material.dart';
import 'team_screen.dart'; // Import the TeamScreen

class NatScreen extends StatelessWidget {
  NatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LeagueId Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to TeamScreen with LFB leagueId
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamScreen(leagueId: '1', name: 'lfb')),
                );
              },
              child: Text('LFB'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to TeamScreen with LF2 leagueId
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamScreen(leagueId: '2',name: 'lf2')),
                );
              },
              child: Text('LF2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to TeamScreen with NF1 Poule A leagueId
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamScreen(leagueId: '3',name: 'NF1 A')),
                );
              },
              child: Text('NF1 A'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to TeamScreen with NF1 Poule B leagueId
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeamScreen(leagueId: '4', name:'NF1 B')),
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
