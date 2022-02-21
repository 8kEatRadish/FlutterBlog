/// 文件： anion.dart
/// 描述： 负离子bean类
/// [x]: 位置x
/// [y]: 位置y
/// [vX]: x速度
/// [vY]: y速度
/// [aX]: x加速度
/// [aY]: y加速度
/// [height]: 负离子高度
/// [alpha]: 负离子透明度
/// [type]: 负离子类型 0 : 十字 ；1 : 圆圈;
class Anion {
  double x;
  double y;
  double vX;
  double vY;
  double aX;
  double aY;
  double height;
  int alpha;
  int type;

  Anion(
      {this.x = 0,
      this.y = 0,
      this.vX = 0,
      this.vY = 0,
      this.aX = 0,
      this.aY = 0,
      this.height = 10,
      this.type = 1,
      this.alpha = 1});
}
