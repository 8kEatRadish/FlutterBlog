import 'dart:ui';

///
/// [aX]: x加速度
/// [aY]: y加速度
/// [vX]: x速度
/// [vY]: y速度
/// [x]: 位置x
/// [y]: 位置y
/// [color]: 小球颜色
/// [r]: 小球半径
class Ball {
  double aX;
  double aY;
  double vX;
  double vY;
  double x;
  double y;
  Color color;
  double r;

  Ball(
      {this.aX = 0,
      this.aY = 0,
      this.vX = 0,
      this.vY = 0,
      this.x = 0,
      this.y = 0,
      this.color,
      this.r = 0});
}
