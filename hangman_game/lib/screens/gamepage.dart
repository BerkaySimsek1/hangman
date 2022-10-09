import 'package:flutter/material.dart';
import 'package:hangman_game/api/gettingWord.dart';
import 'package:hangman_game/screens/conclusionPage.dart';
import 'package:hangman_game/utils/alphabet.dart';
import 'package:hangman_game/widgets/hangman.dart';

class Gamepage extends StatefulWidget {
  const Gamepage({super.key});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  String word = 'AAA';
  List letters = [];
  List choosenLetters = [];
  List controlList = [];
  int life = 6;
  int resultControl = 0;
  bool boolResult = false;
  late Future<List> response;
  @override
  void initState() {
    super.initState();
    response = getWord();

    choosenLetters = [];
  }

  Future<List> getWord() async {
    word = await ApiControl().fetchWord();
    while (word.length >= 8) {
      word = await ApiControl().fetchWord();
    }
    word = word.toUpperCase();
    letters = word.split('');

    return letters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Stack(children: [
          const Icon(
            Icons.favorite,
            size: 50,
          ),
          Positioned(
            top: 10,
            left: 19,
            child: Text(
              life.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          )
        ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: response,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            String letter = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 70,
                                    child: Visibility(
                                      visible: (choosenLetters.contains(letter))
                                          ? true
                                          : false,
                                      child: Text(
                                        letter,
                                        style: const TextStyle(
                                            fontSize: 50, color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          (snapshot.data!.length / 0.8),
                                      child: const Divider(
                                        color: Colors.white,
                                        thickness: 10,
                                        height: 2,
                                      ))
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Expanded(
              flex: 3,
              child: Stack(
                children: [
                  figureImage(life <= 6, "assets/hang.png"),
                  figureImage(life <= 5, "assets/head.png"),
                  figureImage(life <= 4, "assets/body.png"),
                  figureImage(life <= 3, "assets/ra.png"),
                  figureImage(life <= 2, "assets/la.png"),
                  figureImage(life <= 1, "assets/rl.png"),
                  figureImage(life <= 0, "assets/ll.png"),
                ],
              )),
          Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: const EdgeInsets.all(8),
                children: alphabet
                    .map((e) => RawMaterialButton(
                          onPressed: choosenLetters.contains(e)
                              ? null
                              : () {
                                  setState(() {
                                    choosenLetters.add(e);
                                    controlList.add(e);
                                    for (var i in letters) {
                                      boolResult = false;
                                      if (controlList.contains(i)) {
                                        boolResult = true;
                                        controlList.remove(i);
                                        break;
                                      } else {
                                        boolResult = false;
                                      }
                                    }

                                    if (boolResult == false) {
                                      life -= 1;
                                    }
                                    print(letters.toString());
                                    print(choosenLetters);
                                    for (var i in letters) {
                                      if (choosenLetters.contains(i)) {
                                        resultControl += 1;
                                      }
                                      if (resultControl == letters.length) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ConclusionPage(conc: 'Win'),
                                            ));
                                        break;
                                      }
                                    }
                                    resultControl = 0;
                                    if (life == 0) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ConclusionPage(conc: 'Lose'),
                                          ));
                                    }
                                  });
                                },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          fillColor: choosenLetters.contains(e)
                              ? Colors.black87
                              : Colors.blue,
                          child: Text(
                            e,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
              ))
        ],
      ),
    );
  }
}
