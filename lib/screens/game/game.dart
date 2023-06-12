import 'package:bonfire/bonfire.dart';
import 'package:bonfire_game_demo/global/global.dart';
import 'package:bonfire_game_demo/screens/game/character/enemy/enemy.dart';
import 'package:bonfire_game_demo/screens/game/character/player/player.dart';
import 'package:bonfire_game_demo/screens/game/overlay/game_over.dart';
import 'package:bonfire_game_demo/screens/game/overlay/game_won.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      player: CharacterPlayer(
        position: Vector2.all(40),
      ),
      joystick: Joystick(
        directional: JoystickDirectional(),
        keyboardConfig: KeyboardConfig(
          keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
          acceptedKeys: [
            LogicalKeyboardKey.space,
            LogicalKeyboardKey.enter,
          ],
        ),
      ),
      overlayBuilderMap: {
        "game_over": (context, size) => const GameOver(),
        "game_won": (context, size) => const GameWon(),
      },
      map: WorldMapByTiled(Globals.mapOne, objectsBuilder: {
        "enemy": (properties) => CharacterEnemy(
              position: properties.position,
            ),
      }),
    );
  }
}
