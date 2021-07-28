import 'package:get/get.dart';

import 'home/homeView.dart';

/////////////////////////////////////////////
/// 文件： blog_route.dart
/// 描述： 博客页面路由
/// 作者： Suihongwei 2021/3/9
/////////////////////////////////////////////
class RouteConfig {
  //主页
  static final String familyBoardHome = "blog_home";

  static final List<GetPage> getPages = [
    GetPage(name: familyBoardHome, page: () => HomePage())
  ];
}
