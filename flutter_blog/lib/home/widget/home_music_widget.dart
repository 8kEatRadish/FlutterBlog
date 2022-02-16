import 'package:flutter/material.dart';

class HomeMusicWidget extends StatefulWidget {
  const HomeMusicWidget({Key key}) : super(key: key);

  @override
  _HomeMusicWidgetState createState() => _HomeMusicWidgetState();
}

class _HomeMusicWidgetState extends State<HomeMusicWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
      child: Text("我是音乐模块"),
    );
  }
}
