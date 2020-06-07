import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/const.dart';

class GameProvider extends ChangeNotifier {
  bool gameStarted = false;
  bool dartsPlaying = false;
  bool dartsTurn = false;
  bool gameOver = false;
  List dartMoves = [];
  int playIndex = 0;
  int playerIndex = 0;
  int playerHighScore;
  int score;
  ColorBlock currentSelBlock;

  List availColors = [];
  bool get isGameStarted => gameStarted;
  bool get isDartPlaying => dartsPlaying;
  bool get isDartsTurn => dartsTurn;
  bool get isGameOver => gameOver;
  int get currentPlayIndex => playIndex;
  int get currentPlayerIndex => playerIndex;
  int get getPlayerHighScore => playerHighScore;
  int get getScore => score;
  ColorBlock get getCurBlock => currentSelBlock;

  List get getDartMoves => dartMoves;

  setGameRun(status) {
    gameStarted = status;
  }

  setDartsPlaying(status) {
    dartsPlaying = status;
  }

  setDartsTurn(status) {
    dartsTurn = status;
  }

  startGame() {
    resetGame();
    dartPlays();
    setGameRun(true);
    notifyListeners();
  }

  simonClick(ColorBlock selColor) {
    if (dartMoves[playerIndex] != selColor) {
      wrongMove();
    } else {
      playerIndex++;
      notifyListeners();
      if (playerIndex == dartMoves.length) {
        score = playerIndex;
        dartPlays();
      }
    }
  }

  dartPlays() {
    playIndex++;
    dartMoves.add(availColors[randomIndex()]);
    setDartsTurn(true);
  }

  randomIndex() {
    Random rad = Random();
    return rad.nextInt(availColors.length);
  }

  resetGame() {
    dartMoves.clear();
    availColors.clear();
    availColors.add(ColorBlock.blue);
    availColors.add(ColorBlock.green);
    availColors.add(ColorBlock.red);
    availColors.add(ColorBlock.yellow);
  }

  playSequences() {
    setDartsTurn(true);
    setDartsPlaying(true);

    var idxDelay = 1;
    var idx = 1;
    playIndex = 0;

    dartMoves.forEach((data) {
      Future.delayed(Duration(seconds: 1 * idxDelay), () {
        currentSelBlock = data;
        Future.delayed(Duration(milliseconds: 500), () {
          currentSelBlock = null;
          if (dartMoves.length == idx) {
            setDartsTurn(false);
            setDartsPlaying(false);
            playerIndex = idx = 0;
          }
          notifyListeners();
          idx++;
        });

        playIndex = idx;
        notifyListeners();
      });
      idxDelay++;
    });
  }

  wrongMove() async {
    playerHighScore ??= 0;

    if (playerIndex > playerHighScore) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('score', score);
      playerHighScore = score;
    }
    gameOver = true;
    setGameRun(false);
    setDartsPlaying(false);
    setDartsTurn(false);

    notifyListeners();
  }

  getHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    playerHighScore = prefs.getInt('score');
  }
}
