import 'package:flutter/material.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOverMenu';

  // ref to game
  final Pixeladventure gameRef;

  const GameOverMenu({super.key, required this.gameRef});

  get child => null;

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
        child: Center(
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
                // child: CustomButton(
                //     btnText: ("Start Game"),
                //     btnTextColor: Colors.black,
                //     btnColor: Colors.blue,
                //     onTap: ,),
                child: ElevatedButton(
                    onPressed: () {}, child: const Text("Change Color")),
              ),
            ],
          ),
        ),
      ),
    );
    // return Container();
  }

  void onTap() {
    debugPrint('btn pressed');
  }
}

class Pixeladventure {}
