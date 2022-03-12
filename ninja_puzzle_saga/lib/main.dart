import 'dart:async';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ninja_puzzle_saga/components/background.dart';
import 'components/player.dart';
import 'ui/pausemenu.dart';

Future<void> main() async {
  //await Flame.device.setPortrait();
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setPortrait();
  await Flame.device.setPortraitDownOnly();
  //Flame.device.fullScreen();
  final game = Maze();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget(
        mouseCursor: SystemMouseCursors.cell,
        game: game,
        //Work in progress loading screen on game start
        loadingBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        //Work in progress error handling
        errorBuilder: (context, ex) {
          //Print the error in th dev console
          debugPrint(ex.toString());
          return const Center(
            child: Text('Sorry, something went wrong. Reload me'),
          );
        },
        overlayBuilderMap: {
          'pause': (context, Maze game) => PauseMenu(game: game),
        },
      ),
    ),
  );
}

/// This class encapulates the whole game.
class Maze extends FlameGame with HasCollidables, KeyboardEvents, TapDetector {
  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    player.onKeyEvent(event, keysPressed);
    if (keysPressed.contains(LogicalKeyboardKey.enter)) ;
    return super.onKeyEvent(event, keysPressed);
  }

  PlayerComponent player =
      PlayerComponent(position: Vector2(0, 0), size: Vector2(0, 0));

  @override
  Future<void> onLoad() async {
    player = PlayerComponent(position: size / 2.3, size: Vector2.all(20));
    //camera.follow?.setValues(player.position.x, player.position.y);
    await add(Background(position: size / 2, size: Vector2.all(20)));

    await add(player);
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo event) {
    player.onTapDown(event, size);
    return true;
  }

  @override
  bool onTapUp(TapUpInfo event) {
    player.onTapUp(event);
    return true;
  }

  @override
  void update(double dt) {
    camera.follow =
        Vector2(player.position.x - size.x / 2, player.position.y - size.y / 2);
    super.update(dt);
  }
}
