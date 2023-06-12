import 'package:bonfire/bonfire.dart';
import 'package:bonfire_game_demo/global/global.dart';

class EnemySprite {
  static late SpriteSheet spriteSheet;

  static Future<void> load() async {
    final image = await Flame.images.load(Globals.enemy);
    spriteSheet =
        SpriteSheet.fromColumnsAndRows(image: image, columns: 4, rows: 7);
  }
}
