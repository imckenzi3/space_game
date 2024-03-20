import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

// open text
late TextComponent openDoor;

// collisioncalls backs allows us to detect collisions and then do something
class DungeonDoor extends SpriteAnimationComponent with CollisionCallbacks {
  DungeonDoor({
    position,
    size,
  }) : super(position: position, size: size);

  bool nearDoor = false;

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    // position door perfectly - show 'open door' if player over door
    add(RectangleHitbox(
        position: Vector2(18, 0),
        size: Vector2(12, 48),

        // play closed door animation? - might be beable to just
        // get away with open door animation and remove it once
        // player is no longer over door

        // collisionType only checks for something thats active
        collisionType: CollisionType.passive));
  }

  // check if player over door
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player || !nearDoor) _reachedDoor();

    super.onCollision(intersectionPoints, other);
  }

  // play open door animation when player over door
  void _reachedDoor() async {
    nearDoor = true;
    debugPrint('reached dungeon door');

    // generate Dungeon

    // start with a single room
    // each room has a random determined number of doors
    // start with first room and for each possible door random check then place room
    // repeat until we have desired total number of rooms
  }
}
