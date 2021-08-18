import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/widget/run_ball/Ball.dart';
import 'package:get/get.dart';

///
/// [_ball]: 小球信息
/// [_area]: 活动区域
/// [mPaint]: 主画笔
/// [bgPaint]: 背景画笔
/// [_gridPaint]: 网格画笔
/// [_gridPath]: 网格路径
class RunBallView extends CustomPainter {
  List<Ball> _balls;
  Rect _area;
  Paint mPaint;
  Paint bgPaint;

  Path _gridPath;
  Paint _gridPaint;

  RunBallView(this._balls, this._area) {
    mPaint = new Paint();
    bgPaint = new Paint()..color = Color.fromARGB(148, 198, 246, 248);
    _gridPath = new Path();
    _gridPaint = new Paint()
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(_area, bgPaint);
    canvas.save();
    canvas.translate(Get.width/2, Get.height/2);
    _drawGrid(canvas, new Size(Get.width, Get.height));
    _drawAxis(canvas, new Size(Get.width, Get.height));
    canvas.restore();
    _balls.forEach((ball) {
      _drawBall(canvas, ball);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }

  void _drawGrid(Canvas canvas, Size size) {
    _gridPaint
      ..color = Colors.grey
      ..strokeWidth = 0.5;
    _gridPath = _buildGridPath(_gridPath, size);
    canvas.drawPath(_buildGridPath(_gridPath, size), _gridPaint);

    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    canvas.drawPath(_gridPath, _gridPaint);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    canvas.drawPath(_gridPath, _gridPaint);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    canvas.drawPath(_gridPath, _gridPaint);
    canvas.restore();
  }

  void _drawAxis(Canvas canvas, Size size) {
    canvas.drawPoints(PointMode.lines, [
      Offset(-size.width/2, 0) , Offset(size.width/2, 0),
      Offset( 0,-size.height/2) , Offset( 0,size.height/2),
      Offset( 0,size.height/2) , Offset( 0-7.0,size.height/2-10),
      Offset( 0,size.height/2) , Offset( 0+7.0,size.height/2-10),
      Offset(size.width/2, 0) , Offset(size.width/2-10, 7),
      Offset(size.width/2, 0) , Offset(size.width/2-10, -7),
    ], _gridPaint..color=Colors.blueGrey..strokeWidth=1.5);
  }

  void _drawBall(Canvas canvas, Ball ball) {
    canvas.drawCircle(
        Offset(ball.x, ball.y), ball.r, mPaint..color = ball.color);
  }

  Path _buildGridPath(Path path, Size size,{step = 20.0}) {
    for (int i = 0; i < size.height / 2 / step; i++) {
      path.moveTo(0, step * i);
      path.relativeLineTo(size.width / 2, 0);
    }
    for (int i = 0; i < size.width / 2 / step; i++) {
      path.moveTo( step * i,0);
      path.relativeLineTo(0,size.height / 2, );
    }
    return path;
  }
}
