import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/dungeonLevel.dart';
// import 'package:flutter/painting.dart';
import 'package:pixel_adventure/components/jump_button.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

// needs to have HasCollisionDetection so stuff we need to collide can have collisionsCallbacks
class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  // camera
  late CameraComponent cam;
  Player player = Player(character: 'character');

  // create joystick
  late JoystickComponent joystick;

  // checks for if on desktop dont need joystick if on desktop
  bool showControls = false;

  // health bar
  late TextComponent _playerHealth;

  // score
  late TextComponent _playerScore;

  // Returns the size of the playable area of the game window.
  Vector2 fixedResolution = Vector2(650, 360);

  // list of levels we have
  List<String> levelNames = ['level-01', 'level-02', 'level-03', 'level-04'];

  // list of generated room names based on floorplan
  List<String> generatedNames = [];

  final List<int> rooms = [
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89
  ];

  // ref to level we are on
  int currentLevelIndex = 0;

  // ref to Dungeon level we are on
  int currentDungeonLevelIndex = 0;

  // sounds
  bool playSounds = false;
  double soundVolume = 1.0;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    // Generate room names based on randomly generated rooms
    generateRoomNames();

    //   // Initialize the Floorplan class to generate room IDs
    // Floorplan floorplan = Floorplan();
    // generatedNames = floorplan.generateRoomIDs();

    // Call when we want to go to the next level
    _loadlevel();

    // Add joystick and jump button if needed
    if (showControls) {
      addJoystick();
      add(JumpButton());
    }

    // Add player score text component
    _playerScore = TextComponent(
      text: 'Score: 0',
      position: Vector2(10, 10),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Sans',
        ),
      ),
    );
    add(_playerScore);

    // Add player health text component
    _playerHealth = TextComponent(
      text: 'Health: 100%',
      position: Vector2(size.x - 40, 25),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Sans',
        ),
      ),
    );
    _playerHealth.anchor = Anchor.topRight;
    add(_playerHealth);

    return super.onLoad();
  }

  void generateRoomNames() {
    // Clear existing generated names
    generatedNames.clear();

    // Generate room names based on randomly generated rooms
    for (int i = 0; i < levelNames.length; i++) {
      // Assuming a basic format for room names
      String roomName = 'Room ${i + 1}';
      generatedNames.add(roomName);
    }
  }

  // check where joystick is currently positioned
  @override
  void update(double dt) {
    if (showControls) {
      updateJoystick();
    }

    // update score
    _playerScore.text = 'Score: ${player.score}';

    // update health
    _playerHealth.text = 'Health: ${player.health}%';

    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      // sets images as priority (10 layers above 0)
      priority: 10,

      //create knob
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      // where we want to place the joystick
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    // add joystick to game
    add(joystick);
  }

  // grabs joysticks directions
  // based on directions set player direction
  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        // idle
        player.horizontalMovement = 0;
        break;
    }
  }

  // health bar
  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // draw rectangle
    canvas.drawRect(
      Rect.fromLTWH(size.x - 126, 10, player.health.toDouble(), 10),
      Paint()..color = Colors.green,
    );
  }

  void loadNextLevel() {
    removeWhere((component) => component is Level);
    // increase level
    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;

      // prints current level
      debugPrint('Current level: $currentLevelIndex');

      _loadlevel();
    } else {
      // no more levels

      // when you get back to the end level
      // goto the first level - no restarting game
      currentLevelIndex = 0;
      _loadlevel();
    }
  }

  void _loadlevel() {
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      Level world = Level(
        player: player,
        levelName: levelNames[currentLevelIndex],
      );

      // creates cam component w/ fix resolution
      cam = CameraComponent.withFixedResolution(
          world: world, width: 650, height: 360);
      cam.viewfinder.anchor = Anchor.topLeft;

      // load cam first then world
      addAll([cam, world]);
    });
    // @override
    // final world = Level(
    //   player: player,
    //   levelName: levelNames[currentLevelIndex],
    // );

    // // creates cam component w/ fix resolution
    // cam = CameraComponent.withFixedResolution(
    //     world: world, width: 650, height: 360);
    // cam.viewfinder.anchor = Anchor.topLeft;

    // // load cam first then world
    // addAll([cam, world]);
  }

  void loadDungeonLevel() {
    removeWhere((component) => component is DungeonLevel);
    // increase level
    if (currentDungeonLevelIndex < generatedNames.length - 1) {
      currentDungeonLevelIndex++;

      // prints current level
      debugPrint('Current dungeon level: $currentDungeonLevelIndex');

      _loadDungeonlevel();
    } else {
      // no more levels

      // when you get back to the end level
      // goto the first level - no restarting game
      currentDungeonLevelIndex = 0;
      _loadDungeonlevel();
    }
  }

  void _loadDungeonlevel() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        DungeonLevel world = DungeonLevel(
          player: player,
          levelName: generatedNames[currentDungeonLevelIndex],
          rooms: [],
        );

        // creates cam component w/ fix resolution
        cam = CameraComponent.withFixedResolution(
          world: world,
          width: 650,
          height: 360,
        );
        cam.viewfinder.anchor = Anchor.topLeft;

        // load cam first then world
        addAll([cam, world]);
      },
    );
  }
}
