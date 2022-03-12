import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'dart:async';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'line.dart';

//8,2
class Fence extends PositionComponent with HasHitboxes, Collidable {
  /// Create a new player component at the given [position].

  Fence({required Vector2 position, required Vector2 size, this.fenceimg})
      : super(position: position, size: size);

  dynamic fenceimg;
  dynamic component;

  Fence.loadcomponent(
    this.fenceimg, {
    bool active = false,
    int amount = 1,
    double textposX = 0,
    double textposY = 0,
    int amountPerRow = 1,
    double x = 0,
    double y = 0,
  }) {
    super.position = Vector2(x, y);
    super.size = Vector2.all(20);
    component = SpriteComponent();
    component
      ..sprite = Sprite(fenceimg,
          srcPosition: Vector2(textposX, textposY), srcSize: Vector2(16, 16))
      ..size = Vector2(40, 40);
    if (textposX == 0) component.position.add(Vector2(11, 0));
    // ..x = x
    // ..y = y;
  }
  // @override
  // void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
  //   // print(intersectionPoints.iterator.current.x);
  //   super.onCollision(intersectionPoints, other);
  // }

  //Images [fenceimg];
  @override
  Future<void> onLoad() async {
    //debugMode = true;
    await super.onLoad();
    this.collidableType = CollidableType.passive;
    await add(component);
    var box = HitboxRectangle(
        relation: Vector2((component.sprite!.srcPosition.x == 0) ? 0.5 : -1.4,
            (component.sprite!.srcPosition.x == 0) ? 1 : 1.9));
    addHitbox(box);
  }
}
