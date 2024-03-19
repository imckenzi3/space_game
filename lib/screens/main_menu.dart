import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MainMenu extends StatelessWidget {
  static const String ID = 'MainMenu';

  // ref to game
  final Pixeladventure gameRef;

  const MainMenu({super.key, required this.gameRef});

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
