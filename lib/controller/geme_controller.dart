import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/helper/game_logic.dart';
// import 'package:tic_tac_toe_game/game_logic.dart';

class GameProvider extends ChangeNotifier{

    String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];

  Game game = Game();


   void resetGameState() {
    game.board = Game.initGAmeBoard();
    lastValue = "X";
    gameOver = false;
    turn = 0;
    result = "";
    scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
    notifyListeners(); // Notify listeners of the state change
  }

}