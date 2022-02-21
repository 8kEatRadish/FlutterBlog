import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'anion.dart';

class RunAnionView extends CustomPainter {
  final List<Anion> anions;
  Paint _p;

  RunAnionView(this.anions) {
    _p = new Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    anions.forEach((anion) {
      if (anion.type == 0) {
        _drawCircle(canvas, anion);
      } else {
        _drawTenPath(canvas, anion);
      }
    });
  }

  @override
  bool shouldRepaint(covariant RunAnionView oldDelegate) {
    return true;
  }

  void _drawCircle(Canvas canvas, Anion anion) {
    canvas.drawCircle(Offset(anion.x, anion.y), anion.height / 2,
        _p..color = Colors.white.withAlpha(anion.alpha));
  }

  void _drawTenPath(Canvas canvas, Anion anion) {
    // _tenPath
    //   ..moveTo(anion.x - anion.height / 2, anion.y)
    //   ..lineTo(anion.x + anion.height / 2, anion.y)
    //   ..moveTo(anion.x, anion.y - anion.height / 2)
    //   ..lineTo(anion.x, anion.y + anion.height / 2);
    canvas
      ..drawLine(
          Offset(anion.x - anion.height / 2, anion.y),
          Offset(anion.x + anion.height / 2, anion.y),
          _p..color = Colors.white.withAlpha(anion.alpha))
      ..drawLine(
          Offset(anion.x, anion.y - anion.height / 2),
          Offset(anion.x, anion.y + anion.height / 2),
          _p..color = Colors.white.withAlpha(anion.alpha));
  }
}
