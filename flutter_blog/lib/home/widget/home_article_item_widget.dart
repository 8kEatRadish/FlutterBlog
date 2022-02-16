import 'package:flutter/material.dart';

class HomeArticleItemWidget extends StatefulWidget {
  final int index;

  const HomeArticleItemWidget(this.index, {Key key}) : super(key: key);

  @override
  _HomeArticleItemWidgetState createState() => _HomeArticleItemWidgetState();
}

class _HomeArticleItemWidgetState extends State<HomeArticleItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(child: Text((widget.index).toString())),
      color: Colors.black45,
    );
  }
}
