import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog/widget/game/flappy_bird_game.dart';
import 'package:flutter_blog/widget/markdown_styles.dart';
import 'package:flutter_blog/widget/run_ball/run_ball.dart';
import 'package:flutter_blog/widget/skew_shadow_text.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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

  var _result = "";
  dynamic result;

  /// 加载页面
  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void loadAssets() async {
    result = await _loadFromAssets();
    setState(() {
      _result = result.toString();
    });
  }

  /// 读取mk文件
  Future<String> _loadFromAssets() async {
    String filePath = 'assets/markdown/基于ViewModel、LiveData的消息总线OneStepMessage.md';

    String fileContents = await rootBundle.loadString(filePath);
    return fileContents;
  }

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  @override
  Widget build(BuildContext context) {
    // return new Markdown(
    //   controller: ScrollController(),
    //   selectable: true,
    //   data: _result,
    //   syntaxHighlighter: new HighLight(),
    //   styleSheet: new MarkdownStyleSheet(
    //     p: new TextStyle(fontSize: 16),
    //     // h2: new TextStyle(color: Colors.blue, fontSize: 24),
    //   ),
    //   onTapLink: (text,href,title){
    //     _launchURL(href);
    //   },
    // );
    return FlappyBirdGame().widget;
  }
}
