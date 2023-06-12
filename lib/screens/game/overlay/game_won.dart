import 'package:flutter/material.dart';

class GameWon extends StatelessWidget {
  const GameWon({super.key});

  static const id = "game_won";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          children: [
            const Text("Game Won"),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
                child: const Text("Back to Menu"))
          ],
        ),
      ),
    );
  }
}
