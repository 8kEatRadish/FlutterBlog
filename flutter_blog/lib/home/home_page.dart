import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blog/article/model/article_model.dart';
import 'package:flutter_blog/article/model/tags.dart';
import 'package:flutter_blog/home/home_article_list.dart';
import 'package:flutter_blog/home/widget/home_bottom_widget.dart';
import 'package:flutter_blog/home/widget/home_gushi_widget.dart';
import 'package:flutter_blog/home/widget/home_welcome_widget.dart';
import 'package:flutter_blog/widget/app_bar_widget.dart';
import 'package:flutter_blog/widget/home_music_widget.dart';
import 'package:flutter_blog/widget/home_pet_widget.dart';
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

  Future<List<ArticleModel>> _articles =
      Future.delayed(Duration(milliseconds: 2), () {
    List<ArticleModel> list = [];
    for (int i = 0; i < 8; i++) {
      list.add(ArticleModel(
          "title$i", 0, "content", "cover", false, [Tags.Android]));
    }
    return list;
  });

  @override
  Widget build(BuildContext context) {
    // 文章列表
    Widget content = FutureBuilder<List<ArticleModel>>(
        future: _articles,
        builder:
            (BuildContext context, AsyncSnapshot<List<ArticleModel>> snapshot) {
          if (snapshot.hasData) {
            return HomeArticleList(snapshot.data);
          }
          return Container();
        });

    content = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 欢迎模块
          HomeWelcomeWidget(),
          // 古诗模块
          HomeGushiWidget(),
          SizedBox(
            child: content,
            width: Get.width - 300,
            height: Get.width - 300,
          ),
          // 底部信息模块
          HomeBottomWidget()
        ],
      ),
    );

    content = Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: content);

    content = Stack(
      children: [
        content,
        Positioned(bottom: 0, left: 0, child: MusicWidget()),
        Positioned(bottom: 0, right: 0, child: PetWidget()),
        // appBar模块
        Positioned(top: 0, child: AppBarWidget())
      ],
    );

    return content;
  }
}
