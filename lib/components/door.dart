import 'dart:async';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

// health bar
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
    // position door perfectly - show 'open door' if player over door
    add(RectangleHitbox(
        position: Vector2(18, 0),
        size: Vector2(12, 48),

        // collisionType only checks for something thats active
        collisionType: CollisionType.passive));

    //open door if over
  }

  // check if player over door
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player || nearDoor) _reachedDoor();
    super.onCollision(intersectionPoints, other);
  }

  // show open door
  void _reachedDoor() {
    nearDoor = true;
  }
}
