import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../elements/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );
  bool oTurn = true;

  int oScore = 0;
  int xScore = 0;

  int filledBoxes = 0;

  bool winnerFound = false;
  String resultDeclartion = '';

  static const maxSeconds = 30;
  int seconds = maxSeconds;

  Timer? timer;

  int attempts = 0;

  List<String> displyX0 = ['', '', '', '', '', '', '', '', ''];
  List<int> matchIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColor.primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Player 0',
                            style: customFontWhite,
                          ),
                          Text(
                            oScore.toString(),
                            style: customFontWhite,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Player X',
                            style: customFontWhite,
                          ),
                          Text(
                            xScore.toString(),
                            style: customFontWhite,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 5,
                              color: MainColor.primaryColor,
                            ),
                            color: matchIndexes.contains(index)
                                ? MainColor.accentColor
                                : MainColor.secondaryColor),
                        child: Center(
                          child: Text(
                            displyX0[index],
                            style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                              fontSize: 64,
                              color: MainColor.primaryColor,
                            )),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        resultDeclartion,
                        style: customFontWhite,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _BuildTimer()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (isRunning) {
      setState(() {
        if (oTurn && displyX0[index] == '') {
          displyX0[index] = '0';
          filledBoxes++;
        } else if (!oTurn && displyX0[index] == '') {
          displyX0[index] = 'X';
          filledBoxes++;
        }
        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // check 1st row
    if (displyX0[0] == displyX0[1] &&
        displyX0[0] == displyX0[2] &&
        displyX0[0] != '') {
      setState(() {
        resultDeclartion = 'Player ' + displyX0[0] + ' Wins!';
        _updateScore(displyX0[0]);
        matchIndexes.addAll([0, 1, 2]);
        stopTimer();
      });
    }
    // check 2nd row
    if (displyX0[3] == displyX0[4] &&
        displyX0[3] == displyX0[5] &&
        displyX0[3] != '') {
      setState(() {
        resultDeclartion = 'Player ' + displyX0[3] + ' Wins!';
        _updateScore(displyX0[3]);
        matchIndexes.addAll([3, 4, 5]);
        stopTimer();
      });
    }
    // check 3rd row
    if (displyX0[6] == displyX0[7] &&
        displyX0[6] == displyX0[8] &&
        displyX0[6] != '') {
      setState(() {
        resultDeclartion = 'Player ' + displyX0[6] + ' Wins!';
        _updateScore(displyX0[6]);
        matchIndexes.addAll([6, 7, 8]);
        stopTimer();
      });
    }
    // check 1st colum
    if (displyX0[0] == displyX0[3] &&
        displyX0[0] == displyX0[6] &&
        displyX0[0] != '') {
      setState(() {
        resultDeclartion = 'Player ' + displyX0[0] + ' Wins!';
        _updateScore(displyX0[0]);
        matchIndexes.addAll([0, 3, 6]);
        stopTimer();
      });
    }
    // check 2st colum
    if (displyX0[1] == displyX0[4] &&
        displyX0[1] == displyX0[7] &&
        displyX0[1] != '') {
      setState(() {
        resultDeclartion = 'Player ' + displyX0[1] + ' Wins!';
        _updateScore(displyX0[1]);
        matchIndexes.addAll([1, 7, 4]);
        stopTimer();
      });
    }
    // check 3rd colum
    if (displyX0[2] == displyX0[5] &&
        displyX0[2] == displyX0[8] &&
        displyX0[2] != '') {
      setState(() {
        resultDeclartion = 'Player ' + displyX0[2] + ' Wins!';
        _updateScore(displyX0[2]);
        matchIndexes.addAll([2, 5, 8]);
        stopTimer();
      });
    }
    // check diagonal
    if (displyX0[0] == displyX0[4] &&
        displyX0[0] == displyX0[8] &&
        displyX0[0] != '') {
      setState(() {
        resultDeclartion = 'Player ' + displyX0[0] + ' Wins!';
        _updateScore(displyX0[0]);
        matchIndexes.addAll([0, 4, 8]);
        stopTimer();
      });
    }
    if (displyX0[2] == displyX0[4] &&
        displyX0[2] == displyX0[6] &&
        displyX0[2] != '') {
      setState(() {
        resultDeclartion = 'Player ' + displyX0[2] + ' Wins!';
        _updateScore(displyX0[2]);
        matchIndexes.addAll([4, 6, 2]);
        stopTimer();
      });
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclartion = 'Nobody Wins!';
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == '0') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displyX0[i] = '';
      }
       matchIndexes.clear();
      resultDeclartion = '';
    });
    filledBoxes = 0;
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  Widget _BuildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColor.accentColor,
                ),
                Center(
                  child: Text('$seconds',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50,
                      )),
                )
              ],
            ))
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: () {
              startTimer();
              _clearBoard();
              attempts++;
            },
            child: Text(
              attempts == 0 ? 'Start' : 'Play Again',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          );
  }
}
