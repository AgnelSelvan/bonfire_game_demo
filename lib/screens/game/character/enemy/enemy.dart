import 'package:bonfire/bonfire.dart';
import 'package:bonfire_game_demo/global/animations/sprite.dart';
import 'package:bonfire_game_demo/global/collision_configs.dart';
import 'package:bonfire_game_demo/global/global.dart';
import 'package:bonfire_game_demo/global/sprites/enemy.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class CharacterEnemy extends SimpleEnemy
    with ObjectCollision, AutomaticRandomMovement, UseBarLife {
  final _damage = 10.0;
  bool _canAttackMelee = false;

  CharacterEnemy({required super.position})
      : super(
          size: Vector2.all(
            Globals.playerSize,
          ),
          life: 100,
          speed: 140,
          animation: SpritesAnimation.chacterPlayerAnimations(
            EnemySprite.spriteSheet,
          ),
        ) {
    setupBarLife();
    setupCollision(CollisionConfigs.playerCollisionConfig());
  }

  @override
  void die() {
    removeFromParent();
    super.die();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    FlameAudio.play(Globals.explosionSound);
    showDamage(damage, config: const TextStyle(color: Colors.red));
    super.receiveDamage(attacker, damage, identify);
  }

  @override
  void update(double dt) {
    _canAttackMelee = false;
    seeAndMoveToPlayer(
      closePlayer: (player) {
        _canAttackMelee = true;
        if (_canAttackMelee) {
          simpleAttackMelee(
            withPush: false,
            damage: _damage * 2,
            animationRight: SpritesAnimation.cutAnimation(),
            size: size,
          );
        }
      },
      radiusVision: Globals.radiusVision,
    );
    if (!_canAttackMelee) {
      seeAndMoveToAttackRange(
        positioned: (player) {
          simpleAttackRange(
            animationRight: SpritesAnimation.enemyAttack(),
            animationDestroy: SpritesAnimation.smokeEffect(),
            size: size,
          );
        },
        radiusVision: Globals.radiusVision * 2,
        notObserved: () {
          runRandomMovement(
            dt,
            minDistance: Globals.observeMinDistance,
            maxDistance: Globals.observeMaxDistance,
          );
        },
      );
    }
    // runRandomMovement(
    //   dt,
    //   minDistance: Globals.observeMinDistance,
    //   maxDistance: Globals.observeMaxDistance,
    // );
    super.update(dt);
  }
}
