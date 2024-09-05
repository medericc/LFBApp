import 'package:flutter/material.dart';

class AllStarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Star')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllStarListScreen(ligue: "LFB"),
                  ),
                );
              },
              child: Text('LFB'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllStarListScreen(ligue: "LF2"),
                  ),
                );
              },
              child: Text('LF2'),
            ),
          ],
        ),
      ),
    );
  }
}

class AllStarListScreen extends StatelessWidget {
  final String ligue;

  AllStarListScreen({required this.ligue});

  @override
  Widget build(BuildContext context) {
    // Remplacez par la récupération réelle des anciennes All Star
    final List<String> allStars = ['Joueuse 1', 'Joueuse 2', 'Joueuse 3'];

    return Scaffold(
      appBar: AppBar(title: Text('All Star $ligue')),
      body: ListView.builder(
        itemCount: allStars.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allStars[index]),
          );
        },
      ),
    );
  }
}
