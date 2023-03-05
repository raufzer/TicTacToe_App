import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main(){
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  // this widget is the root of the application 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : GameScreen(),
    );
  }
}