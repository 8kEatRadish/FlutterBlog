import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:get/get.dart';

/// appBar标签widget
class HomeTagWidget extends StatefulWidget {
  final String name;
  final IconData iconData;
  final Function() onTap;

  const HomeTagWidget(this.name, this.iconData, this.onTap, {Key key})
      : super(key: key);

  @override
  _HomeTagWidgetState createState() => _HomeTagWidgetState();
}

class _HomeTagWidgetState extends State<HomeTagWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    Widget content = Icon(
      widget.iconData,
      color: isHover
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onPrimary,
    );

    content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        content,
        SizedBox(
          width: 4,
        ),
        Text(
          widget.name,
          style: isHover ? Get.textTheme.headline3 : Get.textTheme.headline2,
        )
      ],
    );

    content = Padding(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: content,
    );

    content = Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: InkWell(
        child: content,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        onHover: (hover) {
          setState(() {
            isHover = hover;
          });
        },
        onTap: widget.onTap,
      ),
    );

    return content;
  }
}
