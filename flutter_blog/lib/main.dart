import 'package:flutter/material.dart';
import 'package:flutter_blog/blog_route.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TextTemplate.appName,
      initialRoute: RouteConfig.familyBoardHome,
      getPages: RouteConfig.getPages,
    );
  }
}
