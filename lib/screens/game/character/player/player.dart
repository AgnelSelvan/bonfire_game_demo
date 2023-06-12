import 'package:bonfire/bonfire.dart';
import 'package:bonfire_game_demo/global/animations/sprite.dart';
import 'package:bonfire_game_demo/global/collision_configs.dart';
import 'package:bonfire_game_demo/global/global.dart';
import 'package:bonfire_game_demo/global/sprites/player.dart';
import 'package:bonfire_game_demo/screens/game/overlay/game_over.dart';
import 'package:bonfire_game_demo/screens/game/overlay/game_won.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CharacterPlayer extends SimplePlayer with ObjectCollision, UseBarLife {
  final _damage = 10.0;
  CharacterPlayer({required super.position})
      : super(
          size: Vector2.all(
            Globals.playerSize,
          ),
          life: 100,
          speed: 180,
          animation: SpritesAnimation.chacterPlayerAnimations(
            PlayerSprite.spriteSheet,
          ),
        ) {
    setupBarLife();
    setupCollision(CollisionConfigs.playerCollisionConfig());
  }

  @override
  void die() {
    FlameAudio.play(Globals.gameOverSound);
    gameRef.pauseEngine();
    gameRef.overlayManager.add(GameOver.id);
    super.die();
  }

  @override
  void update(double dt) {
    if (gameRef.enemies().isEmpty) {
      FlameAudio.play(Globals.success);
      gameRef.pauseEngine();
      gameRef.overlayManager.add(GameWon.id);
    }
    super.update(dt);
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    FlameAudio.play(Globals.explosionSound);
    showDamage(damage, config: const TextStyle(color: Colors.red));
    super.receiveDamage(attacker, damage, identify);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.id == LogicalKeyboardKey.space.keyId &&
        event.event == ActionEvent.DOWN) {
      simpleAttackRange(
        animationRight: SpritesAnimation.playerAttack(),
        animationLeft: SpritesAnimation.playerAttack(),
        animationUp: SpritesAnimation.playerAttack(),
        animationDown: SpritesAnimation.playerAttack(),
        animationDestroy: SpritesAnimation.smokeEffect(),
        size: size,
        damage: _damage,
      );
    } else if (event.id == LogicalKeyboardKey.enter.keyId &&
        event.event == ActionEvent.DOWN) {
      simpleAttackMelee(
        damage: _damage * 2,
        withPush: false,
        size: size,
        animationRight: SpritesAnimation.cutAnimation(),
      );
    }
    super.joystickAction(event);
  }
}
