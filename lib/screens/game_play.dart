import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure.dart';
import 'package:pixel_adventure/screens/game_over_menu.dart';

final PixelAdventure _pixelAdventure = PixelAdventure();

// class GamePlay<String> extends StatelessWidget {
class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _pixelAdventure,
      overlayBuilderMap: {
        GameOverMenu.ID: (BuildContext context, PixelAdventure gameRef) =>
            GameOverMenu(gameRef: Pixeladventure()),
      },
    );
  }
}
