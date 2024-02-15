import 'package:bonfire/base/bonfire_game_interface.dart';
import 'package:flutter/material.dart';
import 'package:jungle_hunter/game.dart';

class GameWonScreen extends StatelessWidget {
  const GameWonScreen({super.key, required this.gameRef});
  final BonfireGameInterface gameRef;

  static String id = "game_won";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: Container(
          color: Colors.grey,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Game Won"),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameScreen()));
                },
                child: const Text("Restart"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
