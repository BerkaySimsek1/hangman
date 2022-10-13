import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hangman_game/screens/gamepage.dart';
import 'package:hangman_game/utils/colors.dart';

class welcomePage extends StatefulWidget {
  welcomePage({super.key});
  @override
  State<welcomePage> createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeWidth = size.width;
    final sizeHeight = size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customAnimatedText(sizeWidth: sizeWidth),
            customButton(
              sizeWidth: sizeWidth,
              sizeHeight: sizeHeight,
              text: "Play",
              which: 1,
            ),
            customButton(
              sizeWidth: sizeWidth,
              sizeHeight: sizeHeight,
              text: "Exit",
              which: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class customAnimatedText extends StatelessWidget {
  const customAnimatedText({
    Key? key,
    required this.sizeWidth,
  }) : super(key: key);

  final double sizeWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: SizedBox(
        width: sizeWidth,
        height: 75,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 75,
            color: Colors.white,
            fontFamily: 'SouthWinds',
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              RotateAnimatedText(
                'Hangman!',
                textStyle: TextStyle(
                  color: textColor,
                ),
              ),
              RotateAnimatedText(
                'Hangman!',
                textStyle: const TextStyle(
                  color: Colors.red,
                ),
              ),
              RotateAnimatedText(
                'Hangman!',
                textStyle: const TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class customButton extends StatefulWidget {
  const customButton({
    Key? key,
    required this.sizeWidth,
    required this.sizeHeight,
    required this.text,
    required this.which,
  }) : super(key: key);

  final double sizeWidth;
  final double sizeHeight;
  final String text;
  final int which;

  @override
  State<customButton> createState() => _customButtonState();
}

class _customButtonState extends State<customButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35.0),
        child: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.red,
                blurRadius: 20,
                offset: Offset(0, 5),
                spreadRadius: -8,
              )
            ]),
            width: widget.sizeWidth / 1.25,
            height: widget.sizeHeight / 15,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.black,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: const Color.fromARGB(255, 42, 104, 135),
                ),
                onPressed: () {
                  switch (widget.which) {
                    case 1:
                      setState(() {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Gamepage(),
                            ));
                      });
                      break;
                    case 2:
                      showAlertDialog(context);
                  }
                },
                child: Text(
                  widget.text,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ))),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget yesButton = TextButton(
      onPressed: () {
        exit(0);
      },
      child: const Text(
        "Yes",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ));

  Widget noButton = TextButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: const Text(
        "No",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ));

  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.indigo[500],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: const Text("Exit"),
    content: const Text("Are you sure you want to quit?"),
    actions: [
      yesButton,
      noButton,
    ],
  );

  showDialog(
    context: context,
    builder: (context) {
      return alert;
    },
  );
}
