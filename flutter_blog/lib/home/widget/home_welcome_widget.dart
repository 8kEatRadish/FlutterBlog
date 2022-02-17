import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:get/get.dart';

class HomeWelcomeWidget extends StatefulWidget {
  const HomeWelcomeWidget({Key key}) : super(key: key);

  @override
  _HomeWelcomeWidgetState createState() => _HomeWelcomeWidgetState();
}

class _HomeWelcomeWidgetState extends State<HomeWelcomeWidget> {
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
        )
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
