import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
        body: MasonryGridView.count(
          itemCount: _items.length,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          // the number of columns
          crossAxisCount: 3,
          // vertical gap between two items
          mainAxisSpacing: 4,
          // horizontal gap between two items
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            // display each item with a card
            return Card(
              // Give each item a random background color
              color: Color.fromARGB(
                  Random().nextInt(256),
                  Random().nextInt(256),
                  Random().nextInt(256),
                  Random().nextInt(256)),
              key: ValueKey(_items[index]['id']),
              child: SizedBox(
                height: _items[index]['height'],
                child: Center(
                  child: Text(_items[index]['title']),
                ),
              ),
            );
          },
        ));
  }
}
