import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOverMenu';

  // ref to game
  final Pixeladventure gameRef;

  const GameOverMenu({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/main_menu.riv"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 100,
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 100,
                // child: ElevatedButton(onPressed: onPressed, child: child),
              ),
            ],
          ),
        ),
      ),
    );
    // return Container();
  }
}

class Pixeladventure {}
