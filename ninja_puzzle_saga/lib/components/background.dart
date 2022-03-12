import 'package:flame/assets.dart';
import 'package:flame/components.dart';
// import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:flame/geometry.dart';
// import 'package:flame/input.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'fence.dart';

//8,2
class Background extends PositionComponent with HasHitboxes, Collidable {
  /// Create a new player component at the given [position].

  Background({
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  Future<void> loadcomponent(
    dynamic img, {
    bool active = false,
    int amount = 1,
    double posX = 0,
    double posY = 0,
    String filename = "Idle.png",
    int amountPerRow = 1,
    double x = 0,
    double y = 0,
  }) async {
    SpriteComponent component = SpriteComponent();
    component
      ..sprite = Sprite(img,
          //Images().fromCache(filename),
          srcPosition: Vector2(posX, posY),
          srcSize: Vector2(16, 16))
      ..size = Vector2(40, 40)
      ..x = x
      ..y = y;
    add(component);
  }

  Future<void> mazeframe() async {
    List<double> datax = [
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      //2nd inside

      6,
      6,
      6,
      6,
      6,
      6,
      6,
      6,
      6,
      6,
      6,
      //3rd inside
      9,
      9,
      9,
      9,
      9,
      9,
      9,
      //4th inside
      18,
      18,
      18,
      18,
      //5th inside

      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      //6th inside
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      //extras
      9,
      9,
      9,

      22,
      22,
      22,
      22,
    ];
    List<double> datay = [
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      23,
      24,
      25,
      //2nd inside

      8,
      9,
      10,
      11,
      12,
      13,
      14,
      18,
      19,
      20,
      21,
      //3rd inside
      11,
      12,
      13,
      14,
      15, 16, 17,
      //4th inside
      11,
      12,
      16,
      17,
      //5th inside

      8,
      9,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,

      //6th inside
      25,
      24,
      23,
      22,
      21,
      20,
      16,
      15,
      14,
      13,
      12,
      11,
      10,
      9,
      8,
      4,
      //extras
      1,
      2,
      3,

      4,
      5,
      6,
      7,
    ];

    List<double> dataxhorizontal = [
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      //2nd inside
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      //3rd inside
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      //4th inside
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      //5th inside
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      //6th inside
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      //extras
    ];
    List<double> datayhorizontal = [
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      3,
      //2nd inside
      7,
      7,
      7,
      7,
      7,
      7,
      7,
      7,
      7,
      7,
      7,
      7,
      7,
      7,
      7,
      //3rd inside
      10,
      10,
      10,
      10,
      10,
      10,
      10,
      10,
      //4th inside
      18,

      18,
      18,
      18,
      18,
      18,
      18,
      18,

      //5th inside
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      22,
      //6th inside

      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      26,
      //extras
    ];

    List<double> dataxbetween = [3];
    List<double> dataybetween = [26];

    List<double> dataxbetween1 = [26];
    List<double> dataybetween1 = [3];

    List<double> dataxbetween2 = [26];
    List<double> dataybetween2 = [26];

    List<double> dataxbetween3 = [];
    List<double> dataybetween3 = [];

    for (int i = 0; i < datax.length; i++) {
      add(Fence.loadcomponent(
        fence,
        textposX: 0 * 16,
        textposY: 1 * 16,
        amount: 1,
        amountPerRow: 1,
        x: datax[i] * 40,
        y: datay[i] * 40,
      ));
    }

    for (int i = 0; i < dataxhorizontal.length; i++) {
      add(Fence.loadcomponent(
        fence,
        textposX: 1 * 16,
        textposY: 0 * 16,
        amount: 1,
        amountPerRow: 1,
        x: dataxhorizontal[i] * 40,
        y: datayhorizontal[i] * 40,
      ));
    }

    for (int i = 0; i < dataxbetween.length; i++) {
      add(Fence.loadcomponent(
        fence,
        textposX: 0 * 16,
        textposY: 2 * 16,
        amount: 1,
        amountPerRow: 1,
        x: dataxbetween[i] * 40,
        y: dataybetween[i] * 40,
      ));
    }

    for (int i = 0; i < dataxbetween1.length; i++) {
      add(Fence.loadcomponent(
        fence,
        textposX: 3.73 * 16,
        textposY: 0 * 16,
        amount: 1,
        amountPerRow: 1,
        x: dataxbetween1[i] * 40,
        y: dataybetween1[i] * 40,
      ));
    }

    for (int i = 0; i < dataxbetween2.length; i++) {
      add(Fence.loadcomponent(
        fence,
        textposX: 3.73 * 16,
        textposY: 2 * 16,
        amount: 1,
        amountPerRow: 1,
        x: dataxbetween2[i] * 40,
        y: dataybetween2[i] * 40,
      ));
    }

    for (int i = 0; i < dataxbetween3.length; i++) {
      add(Fence.loadcomponent(
        fence,
        textposX: 0 * 16,
        textposY: 0 * 16,
        amount: 1,
        amountPerRow: 1,
        x: dataxbetween3[i] * 40,
        y: dataybetween3[i] * 40,
      ));
    }
  }

  Future<void> addall() async {
    int limit = 5;
    for (int i = 0; i < 40; i++) {
      for (int j = 0; j < 5; j++) {
        await loadcomponent(
          water,
          posX: 1 * 16,
          posY: 7 * 16,
          amount: 1,
          amountPerRow: 1,
          x: -39.5 * j - 39.5 * 2,
          y: 39.5 * i - 39.5,
        );
        await loadcomponent(
          water,
          posX: 1 * 16,
          posY: 7 * 16,
          amount: 1,
          amountPerRow: 1,
          x: 39.5 * i - 39.5 * limit,
          y: -39.5 * j - 39.5,
        );
        await loadcomponent(
          water,
          posX: 1 * 16,
          posY: 7 * 16,
          amount: 1,
          amountPerRow: 1,
          x: 39.5 * i - 39.5 * limit,
          y: 39.5 * j + 39.5 * 30,
        );
        await loadcomponent(
          water,
          posX: 1 * 16,
          posY: 7 * 16,
          amount: 1,
          amountPerRow: 1,
          x: 39.5 * j + 39.5 * 30,
          y: 39.5 * i - 39.5 * limit,
        );
      }
    }
    for (int i = 0; i < 30; i++) {
      for (int j = 0; j < 30; j++) {
        await loadcomponent(
          tile,
          posX: 1 * 16,
          posY: 8 * 16,
          amount: 1,
          amountPerRow: 1,
          x: 39.5 * j,
          y: 39.5 * i,
        );
        if (i == 0 || i == 29) {
          double textposx = 16, textposy = 0, posx = 39.5 * j, posy = 39.5 * i;
          if (j == 0) {
            textposx = 0;
          } else if (j == 29) {
            textposx = 4 * 16;
          }
          add(Fence.loadcomponent(
            fence,
            textposX: textposx,
            textposY: textposy,
            amount: 1,
            amountPerRow: 1,
            x: posx,
            y: posy,
          ));
          if (i == 0 || i == 29 || j == 0 || j == 29) {
            textposx = 1 * 16;
            textposy = 8 * 16;
            posx = 39.5 * j;
            posy = -39.5;
            if (i == 29) {
              textposy = 6 * 16;
              posy = 39.5 * 30;
              await loadcomponent(
                water,
                posX: textposx,
                posY: textposy,
                amount: 1,
                amountPerRow: 1,
                x: posx,
                y: posy,
              );
              textposx = 0;
              posx = 39.5 * 30;
              textposy = 7 * 16;
              posy = 39.5 * j;
            }
            if (i == 0) {
              await loadcomponent(
                water,
                posX: textposx,
                posY: textposy,
                amount: 1,
                amountPerRow: 1,
                x: posx,
                y: posy,
              );
              textposx = 2 * 16;
              posx = -39.5;
              textposy = 7 * 16;
              posy = 39.5 * j;
            }

            await loadcomponent(
              water,
              posX: textposx,
              posY: textposy,
              amount: 1,
              amountPerRow: 1,
              x: posx,
              y: posy,
            );
          }
          //addHitbox(HitboxRectangle(relation: Vector2(39.5 * j, 39.5 * i)));
        }
      }
      if (i != 0 && i != 29) {
        add(Fence.loadcomponent(
          fence,
          textposX: 0 * 16,
          textposY: 1 * 16,
          amount: 1,
          amountPerRow: 1,
          x: -39.5 * 0,
          y: 39.5 * i,
        ));
      }
      add(Fence.loadcomponent(
        fence,
        textposX: 0 * 16,
        textposY: 1 * 16,
        amount: 1,
        amountPerRow: 1,
        x: 39.5 * 29,
        y: 39.5 * i,
      ));

      //addHitbox(HitboxPolygon(relation: Vector2(39.5 * 29, 39.5 * i)));
      //addHitbox(HitboxRectangle(relation: Vector2(0, 39.5 * i)));
    }
    //await add(LineComponent(Vector2(0, -9), Vector2(0, 10)));
  }

  dynamic fence;
  dynamic tile;
  dynamic water;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // fence
    fence = await Images().load('Fence.png');
    tile = await Images().load('Floor.png');
    water = await Images().load('Water.png');
    //await Images().load("Fence.png");
    await addall();
    await mazeframe();
    //loadanimation();
    //add(player);
  }

  // @override
  // void update(double time) {
  //   super.update(time);
  // }
}
