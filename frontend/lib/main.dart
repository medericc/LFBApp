import 'package:flutter/material.dart';
import './screens/main_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'League Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),  // Set MainScreen as the initial screen
    );
  }
}
