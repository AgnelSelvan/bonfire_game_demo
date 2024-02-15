import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:jungle_hunter/game.dart';
import 'package:jungle_hunter/player.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await PlayerSprite.load();
  FlameAudio.audioCache.loadAll([
    'game_over.wav',
    'success.wav',
    'fire.wav',
    'explosion.wav',
  ]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
    );
  }
}
