import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:flutter_blog/widget/run_anion/run_anion.dart';
import 'package:get/get.dart';

class HomeWelcomeWidget extends StatefulWidget {
  const HomeWelcomeWidget({Key key}) : super(key: key);

  @override
  _HomeWelcomeWidgetState createState() => _HomeWelcomeWidgetState();
}

class _HomeWelcomeWidgetState extends State<HomeWelcomeWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _size;
  Animation<Color> _color;
  Animation<double> _y;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _size = Tween<double>(
      begin: 40,
      end: 70,
    ).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 1, curve: Curves.ease)));

    _color = ColorTween(
      begin: Get.theme.colorScheme.background,
      end: Get.theme.colorScheme.primary,
    ).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 1, curve: Curves.ease)));

    _y = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        bottomWidget(),
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Text(
              "心有猛虎，细嗅蔷薇",
              style: Get.textTheme.headline4,
            ),
          ),
        ),
        Positioned(
            width: 200,
            height: 200,
            left: Get.width / 2 - 100,
            top: Get.height / 2 + 100,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: _y.value,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: _color.value,
                        size: _size.value,
                      ),
                    )
                  ],
                );
              },
            )),
        RunAnion()
      ],
    );
  }

  // 底部图片
  Widget bottomWidget() => Image.asset(
        AssetsUtils.homeWelcome1,
        fit: BoxFit.cover,
        width: Get.width,
        height: Get.height,
      );
}
