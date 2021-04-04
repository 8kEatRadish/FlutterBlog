import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/app_theme.dart';
import 'package:flutter_blog/utils/config.dart';
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
        child: Row(
          children: [
            FlatButton(
              onPressed: (){
                Get.changeTheme(AppTheme.buildDartTheme());
              },
              child: Text(
                "怎么了黑",
                style: TextStyle(color: Get.theme.primaryColor),
              ),
            ),FlatButton(
              onPressed: (){
                Get.changeTheme(AppTheme.buildLightTheme());
              },
              child: Text(
                "怎么了白",
                style: TextStyle(color: Get.theme.primaryColor),
              ),
            )
          ],
        ));
  }
}
