import 'package:flutter/material.dart';
import 'package:flutter_blog/home/widget/home_welcome_widget.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeArticleList extends StatefulWidget {
  final int size;

  const HomeArticleList(this.size, {Key key}) : super(key: key);

  @override
  _HomeArticleListState createState() => _HomeArticleListState();
}

class _HomeArticleListState extends State<HomeArticleList> {
  @override
  Widget build(BuildContext context) {
    Widget content = GridView.custom(
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

    content = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomeWelcomeWidget(),
          SizedBox(
            child: content,
            width: Get.width - 300,
            height: Get.width - 300,
          )
        ],
      ),
    );
    return content;
  }
}
