import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/app_theme.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logic.dart';
import 'state.dart';

class HomePage extends StatelessWidget {
  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get.find<HomeLogic>().state;

  ///加载页面
  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  bool a = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        height: Get.height,
        color: ColorUtil.appBgColor,
        child: Neumorphic(
          child: Column(
            children: [
              FlatButton(
                onPressed: () {
                  Get.changeTheme(AppTheme.buildDartTheme());
                },
                child: Text(
                  "怎么了黑",
                  style: TextStyle(color: Get.theme.primaryColor),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Get.changeTheme(AppTheme.buildLightTheme());
                },
                child: NeumorphicText(
                  "I love flutter",
                  style: NeumorphicStyle(
                    depth: 20, //customize depth here
                    color: Get.theme.primaryColor, //customize color here
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 18, //customize size here
                    // AND others usual text style properties (fontFamily, fontWeight, ...)
                  ),
                ),
              ),
              Neumorphic(
                child: NeumorphicIcon(
                  Icons.home_outlined,
                  style:
                      NeumorphicStyle(depth: 20, color: Get.theme.accentColor),
                ),
                style: NeumorphicStyle(depth: 20, color: Get.theme.primaryColor),
              ),
              NeumorphicText(
                "I love flutter",
                style: NeumorphicStyle(
                  depth: 20, //customize depth here
                  color: Get.theme.primaryColor, //customize color here
                ),
                textStyle: NeumorphicTextStyle(
                  fontSize: 18, //customize size here
                  // AND others usual text style properties (fontFamily, fontWeight, ...)
                ),
              ),
            ],
          ),
        ));
  }
}
