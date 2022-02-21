import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blog/widget/run_anion/run_anion_view.dart';
import 'package:get/get.dart';

import 'anion.dart';

class RunAnion extends StatefulWidget {
  const RunAnion({Key key}) : super(key: key);

  @override
  RunAnionState createState() => RunAnionState();
}

class RunAnionState extends State<RunAnion>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  List<Anion> _anions = [];
  double _width, _height, _anionHeight;
  Random random = new Random();

  @override
  void initState() {
    _width = Get.width;
    _height = Get.height;
    animationController =
        new AnimationController(duration: Duration(days: 100), vsync: this);
    animationController.addListener(() {
      _anions.forEach((anion) {
        _updateAnion(anion);
      });
      setState(() {});
    });
    startAnimation();

    super.initState();
  }

  void startAnimation() {
    if (animationController.isAnimating) {
      return;
    }
    if (_anions.isEmpty) {
      for (int i = 0; i < 200; i++) {
        _anions.add(_initAnion());
      }
    }
    animationController.forward();
  }

  void stopAnimation() {
    animationController.stop();
    setState(() {
      _anions.clear();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RunAnionView(_anions),
    );
  }

  void _updateAnion(Anion anion) {
    // 计算位置
    anion.x += anion.vX;
    anion.y += anion.vY;
    anion.vX += anion.aX;
    anion.vY += anion.aY;
    if (anion.y < _height * 0.1) {
      anion.alpha = 1;
    } else {
      anion.alpha =
          (((anion.y - _height * 0.1) / (_height * 0.9)) * 255).toInt();
    }
    // 限定上，左，右边界
    if (anion.y < anion.height / 2 ||
        anion.x < anion.height / 2 ||
        anion.x > _width - anion.height / 2) {
      _initAnion(anion: anion);
    }
  }

  Anion _initAnion({Anion anion}) {
    _anionHeight = 7.0 + random.nextInt(8);
    if (anion == null) {
      return Anion(
          height: _anionHeight,
          x: random.nextDouble() * _width,
          y: _height - _anionHeight / 2,
          vY: -random.nextDouble() * 1,
          vX: random.nextDouble() * 0.1 * pow(-1, random.nextInt(20)),
          aY: 0,
          aX: random.nextDouble() * 0.01 * pow(-1, random.nextInt(20)),
          type: random.nextInt(2),
          alpha: 1);
    } else {
      return anion
        ..height = _anionHeight
        ..x = random.nextDouble() * _width
        ..y = _height - _anionHeight / 2
        ..vY = -random.nextDouble() * 1
        ..vX = random.nextDouble() * 0.1 * pow(-1, random.nextInt(20))
        ..aY = 0
        ..type = random.nextInt(2)
        ..aX = random.nextDouble() * 0.001 * pow(-1, random.nextInt(20))
        ..alpha = 1;
    }
  }
}
