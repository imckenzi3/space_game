import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Screen resolution

  // await device portrait first then landscape - by that time game loads
  // load game, sets to full screen, wait, set to landscape, then builds game
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  // Runs game normally
  // runApp(GameWidget(game: kDebugMode ? PixelAdventure() : game));

  // Runs game through menu screens
  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: MainMenu()));
}
