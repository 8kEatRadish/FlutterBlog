import 'package:flutter/material.dart';
import 'package:flutter_blog/blog_route.dart';
import 'package:flutter_blog/controller.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    Get.put(Controller());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 主题
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,

      // 国际化
      translations: IntlMsgs(),
      locale: Locale('zh', 'CN'),
      fallbackLocale: Locale('en', 'US'),


      title: "贰拾肆的宠物_8kEatRadish",
      initialRoute: RouteConfig.familyBoardHome,
      defaultTransition: Transition.fadeIn,
      getPages: RouteConfig.getPages,
    );
  }
}
