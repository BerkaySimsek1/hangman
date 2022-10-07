import 'package:flutter/material.dart';
import 'package:hangman_game/screens/welcomePage.dart';
import 'package:hangman_game/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
      home: const welcomePage(),
    );
  }
}
