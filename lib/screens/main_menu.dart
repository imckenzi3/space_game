// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  static const String ID = 'MainMenu';

  const MainMenu({super.key});

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
            image: AssetImage("images/main_menu.riv"),
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
                  'Main Menu',
                  style: TextStyle(
                    fontSize: 100,
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 100,
                // child: ElevatedButton(
                //   onPressed: () => gameRef, child: Text('elevated btn')),
                // ),
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
