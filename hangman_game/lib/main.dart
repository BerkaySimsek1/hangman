import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hangman_game/screens/gamepage.dart';
import 'package:hangman_game/screens/welcomePage.dart';
import 'package:hangman_game/utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/welcome': (context) => welcomePage(),
        '/game': (context) => Gamepage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Hangman Game',
      theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
      home: welcomePage(),
    );
  }
}
