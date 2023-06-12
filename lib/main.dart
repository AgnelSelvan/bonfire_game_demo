import 'package:bonfire_game_demo/global/global.dart';
import 'package:bonfire_game_demo/global/sprites/enemy.dart';
import 'package:bonfire_game_demo/global/sprites/player.dart';
import 'package:bonfire_game_demo/screens/game/game.dart';
import 'package:bonfire_game_demo/screens/menu/menu.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PlayerSprite.load();
  await EnemySprite.load();
  FlameAudio.audioCache.loadAll([
    Globals.gameOverSound,
    Globals.explosionSound,
    Globals.fireSound,
    Globals.success,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MenuScreen(),
        "/game": (context) => const GameScreen(),
      },
    );
  }
}
