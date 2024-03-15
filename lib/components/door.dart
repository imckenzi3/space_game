import 'dart:async';

import 'package:bonfire/bonfire.dart';

class Door extends SpriteAnimationComponent {
  Door({
    position,
    size,
  }) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() {
    // see door
    debugMode = true;

    add(RectangleHitbox());
  }
}
