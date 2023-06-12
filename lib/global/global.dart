class Globals {
  /// Sounds
  static const String gameOverSound = 'game_over.wav';
  static const String explosionSound = 'explosion.wav';
  static const String fireSound = 'fire.wav';
  static const String success = 'success.wav';

  /// Attack
  static String playerAttack = "effects/water_attack.png";
  static String cut = "effects/cut.png";
  static String smoke = "effects/smoke.png";
  static String enemyAttack = "effects/fire_attack.png";

  /// Characters
  static const String player = 'sprite_sheets/water_boy.png';
  static const String enemy = 'sprite_sheets/fire_boy.png';

  /// Maps
  static const String mapOne = 'map.json';

  /// Sizes
  static const double defaultTileSize = 32.0;
  static const double playerSize = Globals.defaultTileSize * 1.5;

  static var spriteStepTime = 0.2;
  static const double radiusVision = 130;
  static const int observeMaxDistance = 70;
  static const int observeMinDistance = 30;
}
