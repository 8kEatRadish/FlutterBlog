import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blog/article/model/article_model.dart';
import 'package:flutter_blog/article/model/tags.dart';
import 'package:flutter_blog/home/home_article_list.dart';
import 'package:flutter_blog/home/widget/home_bottom_widget.dart';
import 'package:flutter_blog/home/widget/home_gushi_widget.dart';
import 'package:flutter_blog/home/widget/home_welcome_widget.dart';
import 'package:flutter_blog/utils/enums.dart';
import 'package:flutter_blog/widget/app_bar_widget.dart';
import 'package:flutter_blog/widget/home_music_widget.dart';
import 'package:flutter_blog/widget/home_pet_widget.dart';
import 'package:flutter_blog/widget/square_grid_scale_loading.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '../deferred_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final Controller _controller = Get.find();

  // Generate a list of dummy items
  final List<Map<String, dynamic>> _items = List.generate(
      200,
          (index) =>
      {
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

    var ratio = Get.width / Get.height;

    setPageType(ratio);

    setState(() {});
  }

  // 设置页面类型
  void setPageType(double ratio) {
    if (ratio > 1 && _controller.pageType.value != PageType.web) {
      _controller.pageType.value = PageType.web;
      return;
    }
    if (ratio < 0.6 && _controller.pageType.value != PageType.phone) {
      _controller.pageType.value = PageType.phone;
      return;
    }

    if (_controller.pageType.value != PageType.smallWeb) {
      _controller.pageType.value = PageType.smallWeb;
    }
    return;
  }

  Future<List<ArticleModel>> _articles =
  Future.delayed(Duration(milliseconds: 2), () {
    List<ArticleModel> list = [];
    for (int i = 0; i < 8; i++) {
      list.add(ArticleModel(
          "title$i",
          0,
          "content",
          "https://s2.loli.net/2022/02/21/kz6XRHGl52JdZYr.jpg",
          false,
          [Tags.Android]));
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
          return SquareGridScaleLoading();
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
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
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
