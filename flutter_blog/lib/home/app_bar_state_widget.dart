import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/enums.dart';

/// 共享页面类型
class AppBarStateWidget extends InheritedWidget {
  String currentTagName;

  AppBarStateWidget(
      {Key key, @required this.currentTagName, @required Widget child})
      : super(key: key, child: child);

  static AppBarStateWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppBarStateWidget>();
  }

  @override
  bool updateShouldNotify(AppBarStateWidget old) =>
      old.currentTagName != currentTagName;
}
