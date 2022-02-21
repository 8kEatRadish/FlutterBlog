import 'package:flutter/material.dart';
import 'package:flutter_blog/article/model/article_model.dart';

class HomeWebArticleItemWidget extends StatefulWidget {
  final ArticleModel articleModel;

  const HomeWebArticleItemWidget(this.articleModel, {Key key}) : super(key: key);

  @override
  _HomeWebArticleItemWidgetState createState() => _HomeWebArticleItemWidgetState();
}

class _HomeWebArticleItemWidgetState extends State<HomeWebArticleItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(child: Text((widget.articleModel.title).toString())),
      color: Colors.black45,
    );
  }
}
