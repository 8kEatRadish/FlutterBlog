import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeWelcomeWidget extends StatefulWidget {
  const HomeWelcomeWidget({Key key}) : super(key: key);

  @override
  _HomeWelcomeWidgetState createState() => _HomeWelcomeWidgetState();
}

class _HomeWelcomeWidgetState extends State<HomeWelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.yellow,
      child: Center(
        child: Text("我是欢迎页面"),
      ),
    );
  }
}
