import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/enums.dart';

/// 共享页面类型
class HomeShareWidget extends InheritedWidget {
  final PageType pageType;

  HomeShareWidget({Key key, @required this.pageType, @required Widget child})
      : super(key: key, child: child);

  static HomeShareWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomeShareWidget>();
  }

  @override
  bool updateShouldNotify(HomeShareWidget old) => old.pageType != pageType;
}
