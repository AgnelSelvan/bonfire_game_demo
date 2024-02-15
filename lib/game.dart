import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jungle_hunter/character.dart';
import 'package:jungle_hunter/enemy.dart';
import 'package:jungle_hunter/game_over.dart';
import 'package:jungle_hunter/game_won.dart';
import 'package:jungle_hunter/player.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      player: Character(
        position: Vector2.all(700),
        size: Vector2.all(64),
        spriteSheet: PlayerSprite.spriteSheet,
      ),
      overlayBuilderMap: {
        GameWonScreen.id: (context, game) => GameWonScreen(
              gameRef: game,
            ),
        GameOverScreen.id: (context, game) => GameOverScreen(
              gameRef: game,
            ),
      },
      // showCollisionArea: true,
      map: WorldMapByTiled(
        TiledReader.asset('map.json'),
        objectsBuilder: {
          "enemy": (properties) => CharacterEnemy(
                position: properties.position,
                size: Vector2.all(64),
                spriteSheet: PlayerSprite.spriteSheet,
              ),
        },
      ),
      joystick: Joystick(
        directional: JoystickDirectional(),
        keyboardConfig: KeyboardConfig(
          directionalKeys: KeyboardDirectionalKeys.wasd(),
          acceptedKeys: [
            LogicalKeyboardKey.space,
            LogicalKeyboardKey.enter,
          ],
        ),
      ),
    );
  }
}
