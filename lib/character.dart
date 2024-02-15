import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:jungle_hunter/game_over.dart';
import 'package:jungle_hunter/game_won.dart';

class Character extends SimplePlayer with BlockMovementCollision, UseLifeBar {
  final SpriteSheet spriteSheet;
  final _damage = 10.0;
  Character({
    required super.position,
    required super.size,
    required this.spriteSheet,
  }) : super(
          speed: 300,
          animation: SimpleDirectionAnimation(
            idleRight: SpriteAnimation.variableSpriteList(
              [
                spriteSheet.getSprite(6, 7),
              ],
              stepTimes: [0.2],
            ),
            idleDown: SpriteAnimation.variableSpriteList([
              spriteSheet.getSprite(4, 7),
            ], stepTimes: [
              0.2
            ]),
            runRight: SpriteAnimation.variableSpriteList(
              [
                spriteSheet.getSprite(6, 6),
                spriteSheet.getSprite(6, 7),
                spriteSheet.getSprite(6, 8),
              ],
              stepTimes: [
                0.1,
                0.1,
                0.1,
              ],
            ),
            runUp: SpriteAnimation.variableSpriteList(
              [
                spriteSheet.getSprite(7, 6),
                spriteSheet.getSprite(7, 7),
                spriteSheet.getSprite(7, 8),
              ],
              stepTimes: [
                0.1,
                0.1,
                0.1,
              ],
            ),
            runDown: SpriteAnimation.variableSpriteList(
              [
                spriteSheet.getSprite(4, 6),
                spriteSheet.getSprite(4, 7),
                spriteSheet.getSprite(4, 8),
              ],
              stepTimes: [
                0.1,
                0.1,
                0.1,
              ],
            ),
          ),
        ) {
    setupLifeBar();
  }

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(size: size));
    return super.onLoad();
  }

  @override
  void die() {
    gameRef.pauseEngine();
    gameRef.overlays.add(GameOverScreen.id);
    FlameAudio.play('game_over.wav');
    super.die();
  }

  @override
  void update(double dt) {
    if (gameRef.enemies().toList().isEmpty) {
      gameRef.pauseEngine();
      FlameAudio.play('success.wav');
      gameRef.overlays.add(GameWonScreen.id);
      return;
    }
    super.update(dt);
  }

  @override
  void onJoystickAction(JoystickActionEvent event) {
    if (event.id == LogicalKeyboardKey.enter &&
        event.event == ActionEvent.DOWN) {
      simpleAttackMelee(
        damage: _damage,
        // angle: angle,
        // attackFrom: AttackFromEnum.PLAYER_OR_ALLY,
        size: size,
        withPush: false,
        animationRight: SpriteAnimation.load(
          'effects/cut.png',
          SpriteAnimationData.sequenced(
            amount: 5,
            stepTime: 0.2,
            textureSize: Vector2.all(32),
          ),
        ),
      );
    } else if (event.id == LogicalKeyboardKey.space &&
        event.event == ActionEvent.DOWN) {
      simpleAttackRange(
        diagonalEnabled: false,
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
    }
    super.onJoystickAction(event);
  }
}
