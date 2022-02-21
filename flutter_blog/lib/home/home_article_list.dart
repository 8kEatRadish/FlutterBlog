import 'package:flutter/material.dart';
import 'package:flutter_blog/article/model/article_model.dart';
import 'package:flutter_blog/home/widget/home_web_article_item_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// home页文章列表
class HomeArticleList extends StatefulWidget {
  final List<ArticleModel> articleModels;

  const HomeArticleList(this.articleModels, {Key key}) : super(key: key);

  @override
  _HomeArticleListState createState() => _HomeArticleListState();
}

class _HomeArticleListState extends State<HomeArticleList> {
  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
          (context, index) =>
              HomeWebArticleItemWidget(widget.articleModels[index]),
          childCount: widget.articleModels.length),
    );
  }
}
