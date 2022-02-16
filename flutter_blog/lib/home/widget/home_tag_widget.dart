import 'package:flutter/material.dart';
import 'package:flutter_blog/utils/config.dart';

/// appBar标签widget
class HomeTagWidget extends StatefulWidget {
  final String name;
  final IconData iconData;

  const HomeTagWidget(this.name, this.iconData, {Key key}) : super(key: key);

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
          ? ColorUtil.commonTheme1Color()
          : ColorUtil.commonLevel1Color(),
    );

    content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        content,
        Text(
          widget.name,
          style: TextStyle(
              fontSize: 17,
              color: isHover
                  ? ColorUtil.commonTheme1Color()
                  : ColorUtil.commonLevel1Color(),
              decoration: TextDecoration.none),
        )
      ],
    );

    content = Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: content,
    );

    content = MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: content,
    );

    return content;
  }
}
