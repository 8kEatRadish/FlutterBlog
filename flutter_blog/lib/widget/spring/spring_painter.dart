import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

const double _kSpringWidth = 30;

class SpringPainter extends CustomPainter {
  final int count;
  final ValueListenable<double> height;

  Paint _p;

  SpringPainter(this.height,{this.count = 40}):super(repaint: height) {
    _p = new Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Path springPath = new Path();
    canvas.save();

    canvas.translate(size.width / 2, size.height);

    springPath.relativeLineTo(-_kSpringWidth, 0);

    double space = height.value / (count - 1);

    for (int i = 1; i < count; i++) {
      if (i % 2 == 1) {
        springPath.relativeLineTo(_kSpringWidth, -space);
      } else {
        springPath.relativeLineTo(-_kSpringWidth, -space);
      }
    }

    springPath.relativeLineTo(-_kSpringWidth, 0);

    canvas.drawPath(springPath, _p);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SpringPainter oldDelegate) =>
      oldDelegate.count == this.count && oldDelegate.height == this.height;
}
