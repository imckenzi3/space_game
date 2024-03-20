import 'dart:math';

import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class DungeonGenerator extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure> {
  List<List<String>> generateDungeon(int width, int height) {
    List<List<String>> dungeon =
        List.generate(height, (index) => List.generate(width, (index) => '.'));

    Random random = Random();
    int numRooms =
        random.nextInt(10) + 5; // Random number of rooms (between 5 and 14)

    for (int i = 0; i < numRooms; i++) {
      int roomWidth = random.nextInt(width ~/ 4) +
          3; // Room width between 3 and 25% of total width
      int roomHeight = random.nextInt(height ~/ 4) +
          3; // Room height between 3 and 25% of total height

      int roomX = random.nextInt(width - roomWidth - 1) + 1; // Room X position
      int roomY =
          random.nextInt(height - roomHeight - 1) + 1; // Room Y position

      for (int x = roomX; x < roomX + roomWidth; x++) {
        for (int y = roomY; y < roomY + roomHeight; y++) {
          dungeon[y][x] = ' ';
        }
      }
    }

    return dungeon;
  }
}

void main() {
  DungeonGenerator generator = DungeonGenerator();
  List<List<String>> dungeon = generator.generateDungeon(30, 20);

  for (int y = 0; y < dungeon.length; y++) {
    print(dungeon[y].join());
  }
}
