import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

// open text
late TextComponent openDoor;

// collisioncalls backs allows us to detect collisions and then do something
class Door extends SpriteAnimationComponent with CollisionCallbacks {
  Door({
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
    debugPrint('reached door');

    // // // show open door text
    // if (nearDoor = true) {
    //   openDoor = TextComponent(
    //     text: 'Open Door?',
    //     priority: 10,
    //     // open location
    //     position: Vector2(0, -25),
    //   );
    //   openDoor.anchor = Anchor.topLeft;
    // }

    // if door collide with player and player press e

    // open door animation goes here
  }
}
