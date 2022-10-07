import 'package:flutter/material.dart';

class Gamepage extends StatefulWidget {
  const Gamepage({super.key});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: SizedBox(
          width: 75,
          child: Divider(height: 10, thickness: 10, color: Colors.red),
        ),
      ),
    );
  }
}
