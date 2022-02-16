import 'package:flutter/material.dart';

class HomePetWidget extends StatefulWidget {
  const HomePetWidget({Key key}) : super(key: key);

  @override
  _HomePetWidgetState createState() => _HomePetWidgetState();
}

class _HomePetWidgetState extends State<HomePetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Text("我是宠物模块"),
    );
  }
}
