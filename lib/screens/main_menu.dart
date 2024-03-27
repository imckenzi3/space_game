// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:pixel_adventure/screens/game_play.dart';

class MainMenu extends StatelessWidget {
  static const String ID = 'MainMenu';

  const MainMenu({super.key});

  // final palette = context.watch<Palette>();
  // final gamesServicesController = context.watch<GamesServicesController?>();
  // final settingsController = context.watch<SettingsController>();
  // final audioController = context.watch<AudioController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // background color
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage("spaceShip.png"),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: const Text(
                  'Main Menu',
                  style: TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 55,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    // have to call game_play will run the game
                    // onPressed: () => const GamePlay(),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => GamePlay(),
                      ));
                    },
                    child: const Text('Load Game')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
