import 'package:flutter_blog/article/model/tags.dart';

class ArticleModel {
  final String title;
  final String content;
  final int createTime;
  final String cover;
  final bool top;
  final List<Tags> tags;

  ArticleModel(this.title, this.createTime, this.content, this.cover, this.top,
      this.tags);
}
