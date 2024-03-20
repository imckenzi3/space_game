import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  bool isPlatform;

  // calling collision block
  CollisionBlock({
    position,
    size,
    this.isPlatform = false,

    // take position and size give to super - which is PositionComponent
  }) : super(
          position: position,
          size: size,
        ) {
    debugMode = true;
  }
}
