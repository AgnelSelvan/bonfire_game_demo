import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key});
  static const id = "game_over";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          children: [
            const Text("Game Over"),
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
