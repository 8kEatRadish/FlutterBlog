import 'package:flutter/material.dart';
import 'package:flutter_blog/blog_route.dart';
import 'package:flutter_blog/controller.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:get/get.dart';

import 'main.dart' deferred as myApp;

void main() {
  runApp(FutureBuilder(
      future: myApp.loadLibrary(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return myApp.MyApp();
        } else {
          return Text("Loading",
              style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 70),
              textDirection: TextDirection.ltr);
        }
      }));
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
