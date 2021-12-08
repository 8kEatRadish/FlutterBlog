import 'dart:math';
import 'dart:ui';

import 'package:flame/animation.dart' as at;

import 'package:flame/components/animation_component.dart';
import 'package:flame/game.dart';
import 'package:flame/particle.dart';
import 'package:flame/particles/computed_particle.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlappyBirdGame extends BaseGame {
  AnimationComponent player;

  Random rnd = Random();
  Function randomOffset;

  FlappyBirdGame() {
    randomOffset = () => Offset(
          rnd.nextDouble() * 200 - 100,
          rnd.nextDouble() * 200 - 100,
        );

    List<Sprite> sprites =
        [0, 1, 2].map((i) => new Sprite('bird0_$i.png')).toList();
    player = AnimationComponent(
        64.0, 64.0, new at.Animation.spriteList(sprites, stepTime: 0.1));

    // 指定在屏幕上的坐标
    player.x = Get.width / 2; // 若不指定，默认为0
    player.y = Get.height / 2; // 若不指定，默认为0
    player.angle = 0; // 若不指定，默认为0
  }

  @override
  void update(double t) {
    // TODO: implement update
    super.update(t);
    player.update(t);
  }

  @override
  void render(Canvas canvas) {
    // 仅当图片加载完成，x，y和宽高不为0时才会进行渲染
    player.render(canvas);
    super.render(canvas);
  }
}
