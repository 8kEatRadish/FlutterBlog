import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'enums.dart';

ThemeData lightTheme = ThemeData.from(
    colorScheme: ColorScheme.light(
        background: Color(0xffffffff),
        primary: Color(0xff697e9d),
        // appBar背景色
        surface: Color(0xccffffff),
        // 一级文字颜色
        onPrimary: Color(0xff242424),
        // 二级文字颜色
        onSecondary: Color(0xff7f7f7f)),
    textTheme: TextTheme(
        // appBar name
        headline1: TextStyle(
            color: Color(0xff242424),
            fontSize: 26,
            decoration: TextDecoration.none,
            fontFamily: "xingShu"
        ),
        // appBar tag
        // normal
        headline2: TextStyle(
            fontSize: 17,
            color: Color(0xff242424),
            decoration: TextDecoration.none,
            fontFamily: "xingShu"
        ),
        headline3:
        TextStyle(
            fontSize: 17,
            color: Color(0xff697e9d),
            decoration: TextDecoration.none,
            fontFamily: "xingShu"
        ),
        // welcome title
        headline4: TextStyle(
            color: Colors.white, fontSize: 50, fontFamily: "maoCao")));

ThemeData darkTheme = ThemeData.from(
    colorScheme: ColorScheme.dark(
        background: Color(0xff181818),
        primary: Color(0xff697e9d),
        // appBar背景色
        surface: Color(0xcc181818),
        // 一级文字颜色
        onPrimary: Color(0xffd1d1d1),
        // 二级文字颜色
        onSecondary: Color(0xff8b8b8b)),
    textTheme: TextTheme(
        // appBar name
        headline1: TextStyle(
            color: Color(0xffd1d1d1),
            fontSize: 26,
            decoration: TextDecoration.none,
            fontFamily: "xingShu"),
        // appBar tag
        // normal
        headline2: TextStyle(
            fontSize: 17,
            color: Color(0xffd1d1d1),
            decoration: TextDecoration.none,
            fontFamily: "xingShu"),
        headline3: TextStyle(
            fontSize: 17,
            color: Color(0xff697e9d),
            decoration: TextDecoration.none,
            fontFamily: "xingShu"),
        // welcome title
        headline4: TextStyle(
            color: Colors.white, fontSize: 50, fontFamily: "maoCao")));

class ColorUtil {
  ColorUtil._();

  static ThemeType _themeType = ThemeType.light;

  static setTheme(ThemeType type) {
    _themeType = type;
  }
}

class IntlMsgs extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'appName': '贰拾肆的宠物',
          'appBarHome': '主页',
          'appBarTheme': '主题',
          'appBarLanguage': '语言',
        },
        'en_US': {
          'appName': '8kEatRadish',
          'appBarHome': 'Home',
          'appBarTheme': 'Theme',
          'appBarLanguage': 'Language',
        },
      };
}

class TextTemplate {
  TextTemplate._();

  static String languageCn = "zh_CN";
  static String languageEN = "en_US";

  static String appName = "appName";

  static String appBarHome = "appBarHome";
  static String appBarTheme = "appBarTheme";
  static String appBarLanguage = "appBarLanguage";
}

class AssetsUtils {
  AssetsUtils._();

  // image
  static String homeAvatar = "assets/avatar.jpeg";


  // md
  static const String article = "assets/article/基于ViewModel、LiveData的消息总线OneStepMessage.md";
}

TextStyle commonTextStyle = TextStyle(decoration: TextDecoration.none);
