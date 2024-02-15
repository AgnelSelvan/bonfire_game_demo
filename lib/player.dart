import 'package:bonfire/bonfire.dart';

class PlayerSprite {
  static late SpriteSheet spriteSheet;

  static Future<void> load() async {
    final image = await Flame.images.load('sheet.png');
    spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 15,
      rows: 8,
    );
  }
}
