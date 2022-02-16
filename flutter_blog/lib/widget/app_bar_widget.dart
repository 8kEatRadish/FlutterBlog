import 'package:flutter/material.dart';
import 'package:flutter_blog/home/widget/home_tag_widget.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    // 头像
    Widget content = avatarWidget();
    content = Padding(
      padding: EdgeInsets.only(left: 24, right: 24),
      child: content,
    );

    content = Container(
      color: ColorUtil.backgroundColor(),
      width: Get.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          content,
          nameWidget(),
          Expanded(child: Container()),
          HomeTagWidget(TextTemplate.appBarHome(), Icons.home_rounded),
          HomeTagWidget(TextTemplate.appBarHome(), Icons.home_rounded),
          HomeTagWidget(TextTemplate.appBarHome(), Icons.home_rounded),
          HomeTagWidget(TextTemplate.appBarHome(), Icons.home_rounded),
          HomeTagWidget(TextTemplate.appBarHome(), Icons.home_rounded),
          SizedBox(
            width: 24,
          )
        ],
      ),
    );

    content = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: content,
    );

    return content;
  }

  // 名字
  Widget nameWidget() => Text(
        TextTemplate.appName(),
        style: TextStyle(
            color: ColorUtil.commonLevel1Color(),
            fontSize: 20,
            decoration: TextDecoration.none),
      );

  // 头像
  Widget avatarWidget() => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          AssetsUtils.avatar,
          width: 40,
          height: 40,
        ),
      );
}
