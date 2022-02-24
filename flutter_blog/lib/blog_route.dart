import 'package:flutter_blog/article/markdown_page.dart';
import 'package:get/get.dart';

import 'home/home_page.dart';

/////////////////////////////////////////////
/// 文件： blog_route.dart
/// 描述： 博客页面路由
/// 作者： Suihongwei 2021/3/9
/////////////////////////////////////////////
class RouteConfig {
  // 主页
  static final String familyBoardHome = "blog_home";

  // 文章详情页
  static final String articlePage = "article_page";

  static final List<GetPage> getPages = [
    GetPage(name: familyBoardHome, page: () => HomePage()),
    GetPage(name: articlePage, page: (){
      return MarkdownPage();
    })
  ];
}
