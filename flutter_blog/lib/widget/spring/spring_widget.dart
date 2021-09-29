import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/widget/spring/spring_painter.dart';
import 'package:get/get.dart';

const double _kDefaultSpringHeight = 200; //弹簧默认高度
const double _kRateOfMove = 1.5; //移动距离与形变量比值

class SpringWidget extends StatefulWidget {
  const SpringWidget({Key key}) : super(key: key);

  @override
  _SpringWidgetState createState() => _SpringWidgetState();
}

class _SpringWidgetState extends State<SpringWidget>
    with SingleTickerProviderStateMixin {
  ValueNotifier<double> height = ValueNotifier(_kDefaultSpringHeight);
  double s = 0;

  AnimationController _animationController;
  final Duration _duration = new Duration(milliseconds: 400);
  double laseMoveLen = 0;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
    new AnimationController(vsync: this, duration: _duration)
      ..addListener(() {
        _updateHeightByAnim();
      });
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _updateHeight,
      onVerticalDragEnd: _animateToDefault,
      child: Container(
        width: Get.width,
        height: 500,
        child: CustomPaint(
          painter: SpringPainter(height),
        ),
      ),
    );
  }

  double get dx => -s / _kRateOfMove;

  void _updateHeight(DragUpdateDetails details) {
    s += details.delta.dy;
    height.value = _kDefaultSpringHeight + dx;
  }

  void _animateToDefault(DragEndDetails details) {
    laseMoveLen = s;
    _animationController.forward(from: 0);
  }

  void _updateHeightByAnim() {
    s = laseMoveLen * (1 - _animation.value);
    height.value = _kDefaultSpringHeight + dx;
  }

  @override
  void dispose() {
    _animationController.dispose();
    height.dispose();
    super.dispose();
  }
}
