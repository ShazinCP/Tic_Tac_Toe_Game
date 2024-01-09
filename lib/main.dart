import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game/controller/geme_controller.dart';
import 'package:tic_tac_toe_game/view/game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic Tac Toe Game',
        home: GameScreen(),
      ),
    );
  }
}
