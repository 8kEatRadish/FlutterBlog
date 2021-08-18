import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blog/widget/run_ball/run_ball_view.dart';
import 'package:get/get.dart';

import 'Ball.dart';

class RunBall extends StatefulWidget {
  const RunBall({key}) : super(key: key);

  @override
  _RunBallState createState() => _RunBallState();
}

class _RunBallState extends State<RunBall> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  var _oldTime = DateTime.now().millisecondsSinceEpoch;

  var now;

  var _area = Rect.fromLTRB(0 + 40.0, 0 + 200.0, Get.width - 40, Get.height - 40);

  List<Ball> _balls = [];

  Random random = new Random();

  @override
  void initState() {
    animationController =
        new AnimationController(duration: Duration(days: 100), vsync: this);
    animationController.addListener(() {
      _reader();
    });

    for (var i = 0; i < 1000; i++) {
      _balls.add(Ball(
          color: randomRGB(),
          r: 5 + 4 * random.nextDouble(),
          vX: 3*random.nextDouble()*pow(-1, random.nextInt(20)),
          vY:  3*random.nextDouble()*pow(-1, random.nextInt(20)),
          aY: (random.nextDouble() * 0.1) * (random.nextBool() ? -1:1),
          x: Get.width / 2,
          y: Get.height / 2));
    }
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var child = Scaffold(
      body: CustomPaint(
        painter: RunBallView(_balls, _area),
      ),
    );
    return GestureDetector(
      child: child,
      onTap: () {
      },
    );
  }

  void _reader() {
    _balls.forEach((ball) {
      updateBall(ball);
    });
    setState(() {
      now = DateTime.now().millisecondsSinceEpoch;
      print("时间差${now - _oldTime}ms");
      _oldTime = now;
    });
  }

  void updateBall(Ball ball) {
    //运动学公式
    ball.x += ball.vX;
    ball.y += ball.vY;
    ball.vX += ball.aX;
    ball.vY += ball.aY;
    //限定下边界
    if (ball.y > _area.bottom - ball.r) {
      ball.y = _area.bottom - ball.r;
      ball.vY = -ball.vY;
      // ball.color=randomRGB();//碰撞后随机色
    }
    //限定上边界
    if (ball.y < _area.top + ball.r) {
      ball.y = _area.top + ball.r;
      ball.vY = -ball.vY;
      // ball.color=randomRGB();//碰撞后随机色
    }

    //限定左边界
    if (ball.x < _area.left + ball.r) {
      ball.x = _area.left + ball.r;
      ball.vX = -ball.vX;
      // ball.color=randomRGB();//碰撞后随机色
    }

    //限定右边界
    if (ball.x > _area.right - ball.r) {
      ball.x = _area.right - ball.r;
      ball.vX = -ball.vX;
      // ball.color=randomRGB();//碰撞后随机色
    }
  }

  Color randomRGB() {
    return Color.fromARGB(255, random.nextInt(200), random.nextInt(200), random.nextInt(200));
  }
}
