import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// home页文章列表
class HomeArticleList extends StatefulWidget {
  final int size;

  const HomeArticleList(this.size, {Key key}) : super(key: key);

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
          (context, index) => Card(
                child: Center(child: Text((index - 1).toString())),
                color: Colors.black45,
              ),
          childCount: widget.size),
    );
  }
}
