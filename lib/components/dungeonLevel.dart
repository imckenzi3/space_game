import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/components/door.dart';
import 'package:pixel_adventure/components/dungeonDoor.dart';
import 'package:pixel_adventure/components/saw.dart';
import 'package:pixel_adventure/components/coin.dart';
import 'package:pixel_adventure/components/collision_block.dart';
import 'package:pixel_adventure/components/spike.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class DungeonLevel extends World with HasGameRef<PixelAdventure> {
  final List<int> rooms;
  final Player player;

  DungeonLevel(
      {required this.rooms, required this.player, required String levelName});

  late TiledComponent level;
  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    generateLevelName(rooms); // Generating levelName from rooms

    level = await TiledComponent.load('', Vector2.all(24), priority: -1);
    add(level);

    // _spawningObjects();
    // _addCollisions();

    return super.onLoad();
  }

  void _spawningObjects() {
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            player.scale.x = 1;
            add(player);
            break;
          case 'Coin':
            final coin = Coin(
              coin: spawnPoint.name,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(coin);
            break;
          case 'Spike':
            final spike = Spike(
              position: Vector2(spawnPoint.x, spawnPoint.y + 12),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(spike);
            break;
          case 'Saw':
            final isVertical = spawnPoint.properties.getValue('isVertical');
            final offNeg = spawnPoint.properties.getValue('offNeg');
            final offPos = spawnPoint.properties.getValue('offPos');

            final saw = Saw(
              isVertical: isVertical,
              offNeg: offNeg,
              offPos: offPos,
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(saw);
            break;
          case 'Door':
            final door = Door(
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(door);
            break;
          case 'Dungeon':
            final dungeon = DungeonDoor(
              position: Vector2(spawnPoint.x, spawnPoint.y),
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(dungeon);
            break;
          default:
        }
      }
    }
  }

  void _addCollisions() {
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              isPlatform: true,
            );

            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            collisionBlocks.add(block);
            add(block);
        }
      }
    }

    player.collisionBlocks = collisionBlocks;
  }

  // Function to generate levelName from rooms
  String generateLevelName(List<int> rooms) {
    return rooms.map((room) => room.toString()).join('_');
  }
}
