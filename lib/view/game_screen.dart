import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game/constant/sizedbox.dart';
import 'package:tic_tac_toe_game/controller/geme_controller.dart';
import 'package:tic_tac_toe_game/helper/game_logic.dart';
import 'package:tic_tac_toe_game/helper/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  Game game = Game();

  @override
  void initState() {
    super.initState();
    game.board = Game.initGAmeBoard();
    debugPrint("${game.board}");
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: cPrimaryColor,
      body: Consumer<GameProvider>(
        builder: (context, provider, child) {
          return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "It's ${provider.lastValue} turn".toUpperCase(),
              style: const TextStyle(color: cWhiteColor, fontSize: 58),
            ),
            cHeight20,
            SizedBox(
              height: boardWidth,
              width: boardWidth,
              child: GridView.count(
                crossAxisCount: Game.boardLength ~/
                    3, // the ~/ operator allows you to evide to integer and return an int  as a result
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardLength, (index) {
                  return InkWell(
                    onTap: provider.gameOver
                        ? null
                        : () {
                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = provider.lastValue;
                                provider.turn++;
                                provider.gameOver = game.winnerCheck(
                                    provider.lastValue, index, provider.scoreBoard, 3);
                                if (provider.gameOver) {
                                  provider.result = "${provider.lastValue} is the Winner";
                                } else if (!provider.gameOver && provider.turn == 9) {
                                  provider.result = "It's a Draw!";
                                  provider.gameOver = true;
                                }
                                if (provider.lastValue == "X") {
                                  provider.lastValue = "O";
                                } else {
                                  provider.lastValue = "X";
                                }
                              });
                            }
                          },
                    child: Container(
                      height: Game.blocSize,
                      width: Game.blocSize,
                      decoration: BoxDecoration(
                        color: cSecondaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? cPinkColor
                                : cBlueColor,
                            fontSize: 64.0,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            cHeight25,
            Text(
              provider.result,
              style: const TextStyle(
                color: cWhiteColor,
                fontSize: 54.0,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  game.board = Game.initGAmeBoard();
                  provider.lastValue = "X";
                  provider.gameOver = false;
                  provider.turn = 0;
                  provider.result = "";
                  provider.scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
              icon: const Icon(Icons.replay),
              label: const Text("Repeat the Game"),
            )
          ],
        );
        },
      ),
    );
  }
}
