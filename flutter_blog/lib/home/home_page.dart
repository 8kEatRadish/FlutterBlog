import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/**
 * https://gravual.com/
 */
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Generate a list of dummy items
  final List<Map<String, dynamic>> _items = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "This is test!",
            "height": Random().nextInt(150) + 50
          });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Text("leading"),
          title: Text("title"),
        ),
        body: GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
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
                    child: Center(child: Text(index.toString())),
                    color: Colors.black45,
                  ),
              childCount: 8),
        ));
  }
}
