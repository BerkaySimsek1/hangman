import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hangman_game/screens/gamepage.dart';
import 'package:hangman_game/screens/welcomePage.dart';
import 'package:vibration/vibration.dart';

class ConclusionPage extends StatefulWidget {
  const ConclusionPage({super.key, required this.conc, required this.word});
  final String conc, word;

  @override
  State<ConclusionPage> createState() => _ConclusionPageState();
}

class _ConclusionPageState extends State<ConclusionPage> {
  final audio = AssetsAudioPlayer();

  void winorlosesound() {
    if (widget.conc == "Win!") {
      audio.open(Audio("assets/win.mp3"));
    } else {
      audio.open(Audio("assets/lose.mp3"));
    }
  }

  Future<void> vibrate(String vibrateSetting) async {
    bool? canVibrate = await Vibration.hasVibrator();

    if (canVibrate! &&
        widget.conc == "Win!" &&
        vibrateSetting == "vibrationOn") {
      Vibration.vibrate(
          pattern: [100, 100, 100, 100, 100, 100, 100, 100, 100, 100]);
    } else if (canVibrate &&
        widget.conc == "Lose." &&
        vibrateSetting == "vibrationOn") {
      Vibration.vibrate(duration: 1000);
    } else {
      Vibration.cancel();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vibrate("vibrationOn");
    winorlosesound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(animatedTexts: [
              TypewriterAnimatedText(
                speed: const Duration(milliseconds: 300),
                "You ${widget.conc}",
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    shadows: [
                      Shadow(
                          blurRadius: 7,
                          color: Colors.red,
                          offset: Offset(5, 0))
                    ]),
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your word was:",
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            Text(
              widget.word,
              style: TextStyle(
                  fontSize: 45,
                  color: (widget.conc) == "Win!" ? Colors.green : Colors.red),
            ),
            concPageElevatedButtons(
              text: "Play Again",
              onPressed: 1,
            ),
            concPageElevatedButtons(text: "Main Menu", onPressed: 2)
          ],
        ),
      ),
    );
  }
}

class concPageElevatedButtons extends StatelessWidget {
  concPageElevatedButtons(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);
  String text;
  int onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.25,
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.black,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: const Color.fromARGB(255, 42, 104, 135)),
            onPressed: () {
              switch (onPressed) {
                case 1:
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Gamepage(),
                      ));
                  break;
                case 2:
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => welcomePage(),
                      ));
                  break;
              }
            },
            child: Text(text)),
      ),
    );
  }
}
