// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/geometry.dart';

enum Direction { down, up, left, right }

class PlayerComponent extends PositionComponent
    with HasHitboxes, Collidable, KeyboardHandler {
  /// Create a new player component at the given [position].

  PlayerComponent({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  var player = SpriteAnimationComponent();
  bool moving = false;
  bool moveexecuting = false;
  bool animating = false;
  bool dataloaded = false;
  bool animateidle = false;
  List<Direction> restrictedmovements = [];
  List<Collidable> colliders = [];
  LogicalKeyboardKey keypress = LogicalKeyboardKey.abort;
  Direction direction = Direction.down;
  List<SpriteAnimationComponent> animations = [];

  void loadanimation({
    int amount = 1,
    double texrturePositionX = 0,
    String filename = "Idle.png",
    int amountPerRow = 1,
    double x = 0,
    double y = 0,
  }) {
    var spritesheet = Images().load(filename);
    SpriteAnimationData spritedata = SpriteAnimationData.variable(
        texturePosition: Vector2(texrturePositionX, 1),
        amount: amount,
        amountPerRow: amountPerRow,
        stepTimes: List.generate(amount, (index) => 0.2),
        textureSize: Vector2(16, 16));
    spritesheet.then(
      (value) => {
        player.removeFromParent(),
        player = SpriteAnimationComponent.fromFrameData(
          value,
          spritedata,
        )
          ..x = x
          ..y = y
          ..size = Vector2(40, 40),
        if (amount > 2) player.animation?.currentIndex = 3,
        add(player),
      },
    );
  }

  Future<void> loadanimationtolist() async {
    double texrturePositionX = 0;
    String filename = "Player.png";
    int amount = 4;
    var spritesheet = await Images().load(filename);
    for (int i = 0; i < 8; i++, texrturePositionX += 16) {
      if (i == 4) {
        amount = 1;
        texrturePositionX = 0;
        filename = "Idle.png";
        spritesheet = await Images().load(filename);
      }
      SpriteAnimationComponent temp;
      SpriteAnimationData spritedata = SpriteAnimationData.variable(
          texturePosition: Vector2(texrturePositionX, 1),
          amount: amount,
          amountPerRow: 1,
          stepTimes: List.generate(amount, (index) => 0.2),
          textureSize: Vector2(16, 16));

      temp = SpriteAnimationComponent.fromFrameData(
        spritesheet,
        spritedata,
      )
        ..x = 0
        ..y = 0
        ..size = Vector2(40, 40);
      animations.add(temp);
    }
    player = animations[4];
    transform.x += 100;
    transform.y += 100;
    add(player);
    dataloaded = true;
  }

  void move() async {
    if (moveexecuting) return;
    moveexecuting = true;
    int index = 0;
    double speed = 5;
    if (!moving) {
      index = 4;
      animating = false;
    }
    if (moving) {
      index = 0;
      if (keypress == LogicalKeyboardKey.arrowDown) {
        direction = Direction.down;
        if (animating && !restrictedmovements.contains(direction))
          transform.y += speed;
      } else if (keypress == LogicalKeyboardKey.arrowUp) {
        direction = Direction.up;
        if (animating && !restrictedmovements.contains(direction))
          transform.y -= speed;
      } else if (keypress == LogicalKeyboardKey.arrowRight) {
        direction = Direction.right;
        if (animating && !restrictedmovements.contains(direction))
          transform.x += speed;
      } else // if (keypress == LogicalKeyboardKey.arrowLeft)
      {
        direction = Direction.left;
        if (animating && !restrictedmovements.contains(direction))
          transform.x -= speed;
      }
    }
    if (!animating) {
      player.removeFromParent();
      player = animations[direction.index + index];
      add(player);
      animating = true;
    }
    moveexecuting = false;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (!event.repeat && !moving) {
      moving = true;
      animating = false;
      keypress = keysPressed.first;
    } else if (!event.repeat && moving) {
      moving = false;
      keypress = LogicalKeyboardKey.abort;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  bool onTapDown(TapDownInfo event, Vector2 size) {
    double screenratio = size.y / size.x;
    if (!moving) {
      moving = true;
      animating = false;
      if (event.eventPosition.viewport.y >
              screenratio * event.eventPosition.viewport.x &&
          event.eventPosition.viewport.y - size.y / 2 >
              -(screenratio * (event.eventPosition.viewport.x - size.x / 2))) {
        keypress = LogicalKeyboardKey.arrowDown;
      } else if (event.eventPosition.viewport.y <
              screenratio * event.eventPosition.viewport.x &&
          event.eventPosition.viewport.y - (size.y / 2) <
              -(screenratio *
                  (event.eventPosition.viewport.x - (size.x / 2)))) {
        keypress = LogicalKeyboardKey.arrowUp;
      } else if (event.eventPosition.viewport.y >
              screenratio * event.eventPosition.viewport.x &&
          event.eventPosition.viewport.y - size.y / 2 <
              -(screenratio * (event.eventPosition.viewport.x - size.x / 2))) {
        keypress = LogicalKeyboardKey.arrowLeft;
      } else //if (event.eventPosition.viewport.y >
      //event.eventPosition.viewport.x &&
      //event.eventPosition.viewport.y + size.y / 2 <
      //  -event.eventPosition.viewport.x + size.x / 2)
      {
        keypress = LogicalKeyboardKey.arrowRight;
      }
    }
    return true;
  }

  bool onTapUp(TapUpInfo event) {
    if (moving) {
      moving = false;
      keypress = LogicalKeyboardKey.abort;
    }
    return true;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await loadanimationtolist();
    collidableType = CollidableType.active;
    //addHitbox(HitboxRectangle());
    //loadanimation();
    addHitbox(HitboxRectangle(relation: Vector2(2, 2)));
    //add(player);
  }

  bool movewtanim = false;

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (colliders.contains(other)) return;
    colliders.add(other);
    restrictedmovements.add(direction);
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(Collidable other) {
    for (int i = 0; i < colliders.length; i++) {
      if (colliders[i] == other) {
        colliders.removeAt(i);
        restrictedmovements.removeAt(i);
        break;
      }
    }
    super.onCollisionEnd(other);
  }
  // @override
  // void render(Canvas canvas) {
  //   //add(player);
  //   super.render(canvas);
  // }

  @override
  void update(double dt) {
    if (dataloaded) move();
    super.update(dt);
  }
}
