import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeWelcomeTitleWidget extends StatefulWidget {
  const HomeWelcomeTitleWidget({Key key}) : super(key: key);

  @override
  _HomeWelcomeTitleWidgetState createState() => _HomeWelcomeTitleWidgetState();
}

class _HomeWelcomeTitleWidgetState extends State<HomeWelcomeTitleWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _textSize;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _textSize = Tween<double>(
      begin: 50,
      end: 70,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (hover) {
        if (hover) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      onTap: () {},
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Text(
            "心有猛虎，细嗅蔷薇",
            style: Get.textTheme.headline4.copyWith(fontSize: _textSize.value),
          );
        },
      ),
    );
  }
}
