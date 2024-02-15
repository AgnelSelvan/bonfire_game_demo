import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class CharacterEnemy extends SimpleEnemy
    with AutomaticRandomMovement, UseLifeBar, BlockMovementCollision {
  final _damage = 10.0;
  final SpriteSheet spriteSheet;
  bool _canAttackMele = false;
  CharacterEnemy({
    required super.position,
    required super.size,
    required this.spriteSheet,
  }) : super(
          animation: SimpleDirectionAnimation(
            idleRight: SpriteAnimation.variableSpriteList(
              [spriteSheet.getSprite(0, 7)],
              stepTimes: [0.2],
            ),
            runRight: SpriteAnimation.variableSpriteList(
              [
                spriteSheet.getSprite(2, 6),
                spriteSheet.getSprite(2, 7),
                spriteSheet.getSprite(2, 8),
              ],
              stepTimes: [0.2, 0.2, 0.2],
            ),
            runUp: SpriteAnimation.variableSpriteList(
              [
                spriteSheet.getSprite(3, 6),
                spriteSheet.getSprite(3, 7),
                spriteSheet.getSprite(3, 8),
              ],
              stepTimes: [0.2, 0.2, 0.2],
            ),
          ),
        ) {
    setupLifeBar(
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  void die() {
    removeFromParent();
    super.die();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    FlameAudio.play('explosion.wav');
    showDamage(damage, config: const TextStyle(color: Colors.red));
    super.receiveDamage(attacker, damage, identify);
  }

  @override
  Future<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _canAttackMele = false;
    seeAndMoveToPlayer(
      radiusVision: 130,
      notObserved: () {
        runRandomMovement(dt);
        return false;
      },
      observed: () {
        _canAttackMele = true;
        if (_canAttackMele) {
          simpleAttackMelee(
            damage: _damage,
            size: size,
            animationRight: SpriteAnimation.load(
              'effects/cut.png',
              SpriteAnimationData.sequenced(
                amount: 5,
                stepTime: 0.2,
                textureSize: Vector2.all(32),
              ),
            ),
          );
        }
      },
    );
    if (!_canAttackMele) {
      seeAndMoveToAttackRange(
        radiusVision: 230,
        notObserved: () {
          print("object");
          runRandomMovement(dt, maxDistance: 100, minDistance: 50);
          return false;
        },
        positioned: (position) {
          simpleAttackRange(
            speed: 500,
            animationRight: SpriteAnimation.load(
              'effects/fire_attack.png',
              SpriteAnimationData.sequenced(
                amount: 1,
                stepTime: 0.2,
                textureSize: Vector2.all(32),
              ),
            ),
            animationDestroy: SpriteAnimation.load(
              'effects/smoke.png',
              SpriteAnimationData.sequenced(
                amount: 1,
                stepTime: 0.2,
                textureSize: Vector2.all(32),
              ),
            ),
            size: size,
            damage: _damage,
          );
        },
      );
    }
    super.update(dt);
  }
}
