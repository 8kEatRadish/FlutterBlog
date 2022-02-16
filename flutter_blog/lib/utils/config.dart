import 'package:flutter/cupertino.dart';

import 'enums.dart';

class ColorUtil {
  ColorUtil._();

  static ThemeType _themeType = ThemeType.light;

  static setTheme(ThemeType type) {
    _themeType = type;
  }

  // 一级文字颜色
  static Color commonLevel1Color() {
    switch (_themeType) {
      case ThemeType.light:
        return Color(0xff242424);
        break;
      case ThemeType.dark:
        return Color(0xffd1d1d1);
        break;
    }
    return Color(0xff242424);
  }

  // 二级文字颜色
  static Color commonLevel2Color() {
    switch (_themeType) {
      case ThemeType.light:
        return Color(0xff7f7f7f);
        break;
      case ThemeType.dark:
        return Color(0xff8b8b8b);
        break;
    }
    return Color(0xff7f7f7f);
  }

  // 背景颜色
  static Color backgroundColor() {
    switch (_themeType) {
      case ThemeType.light:
        return Color(0xffffffff);
        break;
      case ThemeType.dark:
        return Color(0xff181818);
        break;
    }
    return Color(0xffffffff);
  }

  // 主题颜色
  static Color commonTheme1Color() {
    return Color(0xff697e9d);
  }
}

class TextTemplate {
  TextTemplate._();

  static LanguageType _languageType = LanguageType.en;

  static setLanguageType(LanguageType type) {
    _languageType = type;
  }

  //博客title
  static String appName() {
    switch (_languageType) {
      case LanguageType.cn:
        return "贰拾肆的宠物";
        break;
      case LanguageType.en:
        return "8kEatRadish";
        break;
      default:
        return "8kEatRadish";
    }
  }

  /// app_bar_widget
  // 主页
  static String appBarHome() {
    switch (_languageType) {
      case LanguageType.cn:
        return "主页";
        break;
      case LanguageType.en:
        return "Home";
        break;
      default:
        return "Home";
    }
  }
}

class AssetsUtils {
  AssetsUtils._();

  static String avatar = "assets/avatar.jpeg";
}

TextStyle commonTextStyle = TextStyle(decoration: TextDecoration.none);
