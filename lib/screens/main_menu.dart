// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:pixel_adventure/screens/game_over_menu.dart';
import 'package:pixel_adventure/screens/game_play.dart';

class MainMenu extends StatelessWidget {
  static const String ID = 'MainMenu';

  const MainMenu({super.key});

  // MainMenu({super.key, required this.gameRef});

  // ref to game
  // final Pixeladventure gameRef;

  // const MainMenu({super.key, required this.gam eRef});

  // const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/spaceShip.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  'Main Menu',
                  style: TextStyle(
                    fontSize: 100,
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 100,
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
