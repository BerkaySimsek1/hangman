import 'package:flutter/material.dart';

class ConclusionPage extends StatefulWidget {
  const ConclusionPage({super.key, required this.conc});
  final String conc;

  @override
  State<ConclusionPage> createState() => _ConclusionPageState();
}

class _ConclusionPageState extends State<ConclusionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.conc,
              style: const TextStyle(fontSize: 50),
            )
          ],
        ),
      ),
    );
  }
}
