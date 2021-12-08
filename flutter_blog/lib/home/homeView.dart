import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blog/widget/run_ball/run_ball.dart';
import 'package:flutter_blog/widget/skew_shadow_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'homeLogic.dart';
import 'homeState.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeLogic logic = Get.put(HomeLogic());

  final HomeState state = Get.find<HomeLogic>().state;

  ///加载页面
  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  bool a = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RunBall(),
        Container(
          width: Get.width,
          height: 200,
          alignment: Alignment.center,
          child: SkewShadowText("Blog装修中。。。"),
        )
      ],
    );
  }
}
