import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blog/home/home_article_list.dart';
import 'package:flutter_blog/home/widget/home_gushi_widget.dart';
import 'package:flutter_blog/home/widget/home_welcome_widget.dart';
import 'package:flutter_blog/widget/app_bar_widget.dart';
import 'package:get/get.dart';

/// https://gravual.com/
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  // Generate a list of dummy items
  final List<Map<String, dynamic>> _items = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "This is test!",
            "height": Random().nextInt(150) + 50
          });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    setState(() {
      print("width = ${Get.width}; height = ${Get.height}");
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = HomeArticleList(8);

    content = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomeWelcomeWidget(),
          HomeGushiWidget(),
          SizedBox(
            child: content,
            width: Get.width - 300,
            height: Get.width - 300,
          )
        ],
      ),
    );

    content = Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: content);

    content = Stack(
      children: [content, Positioned(top: 0, child: AppBarWidget())],
    );

    return content;
  }
}
