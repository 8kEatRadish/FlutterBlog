import 'package:flutter/material.dart';
import 'package:flutter_blog/blog_route.dart';
import 'package:flutter_blog/controller.dart';
import 'package:flutter_blog/widget/home_tag_widget.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final Controller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // 头像
    Widget content = avatarWidget();
    content = Padding(
      padding: EdgeInsets.only(left: 24, right: 24),
      child: content,
    );

    content = Container(
      width: Get.width,
      height: 50,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              offset: Offset(0, 3),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          content,
          nameWidget(),
          Expanded(child: Container()),
          HomeTagWidget(TextTemplate.appBarTheme.tr, Icons.color_lens, () {
            if (Get.isDarkMode) {
              Get.changeThemeMode(ThemeMode.light);
            } else {
              Get.changeThemeMode(ThemeMode.dark);
            }
          }),
          HomeTagWidget(TextTemplate.appBarLanguage.tr, Icons.language_rounded,
              () {
            if (_controller.languageType.value == TextTemplate.languageCn) {
              Get.updateLocale(Locale(TextTemplate.languageEN));
              _controller.languageType.value = TextTemplate.languageEN;
            } else {
              Get.updateLocale(Locale(TextTemplate.languageCn));
              _controller.languageType.value = TextTemplate.languageCn;
            }
          }),
          HomeTagWidget(TextTemplate.appBarHome.tr, Icons.home_rounded, () {
            Get.snackbar("title", "home");
          }),
          SizedBox(
            width: 24,
          )
        ],
      ),
    );

    return content;
  }

  // 名字
  Widget nameWidget() => Text(
        TextTemplate.appName.tr,
        style: Get.textTheme.headline1,
      );

  // 头像
  Widget avatarWidget() => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          AssetsUtils.homeAvatar,
          width: 40,
          height: 40,
        ),
      );
}
