import 'package:bonfire/bonfire.dart';
import 'package:bonfire_game_demo/global/global.dart';

class SpritesAnimation {
  static SimpleDirectionAnimation chacterPlayerAnimations(SpriteSheet sheet) {
    return SimpleDirectionAnimation(
      idleDown: SpriteAnimation.variableSpriteList(
        [
          sheet.getSprite(0, 0),
          sheet.getSprite(1, 0),
        ],
        stepTimes: [
          Globals.spriteStepTime,
          Globals.spriteStepTime,
        ],
      ),
      runDown: SpriteAnimation.variableSpriteList(
        List.generate(7, (index) => sheet.getSprite(index, 0)),
        stepTimes: List.generate(7, (index) => Globals.spriteStepTime),
      ),
      idleUp: SpriteAnimation.variableSpriteList(
        [
          sheet.getSprite(0, 1),
          sheet.getSprite(1, 1),
        ],
        stepTimes: [
          Globals.spriteStepTime,
          Globals.spriteStepTime,
        ],
      ),
      runUp: SpriteAnimation.variableSpriteList(
        List.generate(7, (index) => sheet.getSprite(index, 1)),
        stepTimes: List.generate(7, (index) => Globals.spriteStepTime),
      ),
      idleRight: SpriteAnimation.variableSpriteList(
        [
          sheet.getSprite(0, 3),
        ],
        stepTimes: [
          Globals.spriteStepTime,
        ],
      ),
      runRight: SpriteAnimation.variableSpriteList([
        sheet.getSprite(0, 3),
        sheet.getSprite(1, 3),
        sheet.getSprite(2, 3),
        sheet.getSprite(3, 3),
        sheet.getSprite(4, 3),
        sheet.getSprite(5, 3),
        sheet.getSprite(6, 3),
      ], stepTimes: [
        Globals.spriteStepTime,
        Globals.spriteStepTime,
        Globals.spriteStepTime,
        Globals.spriteStepTime,
        Globals.spriteStepTime,
        Globals.spriteStepTime,
        Globals.spriteStepTime,
      ]),
    );
  }

  static Future<SpriteAnimation> playerAttack() {
    return SpriteAnimation.load(
      Globals.playerAttack,
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2.all(32),
        stepTime: Globals.spriteStepTime,
      ),
    );
  }

  static Future<SpriteAnimation> enemyAttack() {
    return SpriteAnimation.load(
      Globals.enemyAttack,
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2.all(32),
        stepTime: Globals.spriteStepTime,
      ),
    );
  }

  static Future<SpriteAnimation> smokeEffect() {
    return SpriteAnimation.load(
      Globals.smoke,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2.all(32),
        stepTime: Globals.spriteStepTime,
      ),
    );
  }

  static Future<SpriteAnimation> cutAnimation() {
    return SpriteAnimation.load(
      Globals.cut,
      SpriteAnimationData.sequenced(
        amount: 5,
        textureSize: Vector2.all(32),
        stepTime: Globals.spriteStepTime,
      ),
    );
  }
}
