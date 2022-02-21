import 'package:flutter/material.dart';

class PetWidget extends StatefulWidget {
  const PetWidget({Key key}) : super(key: key);

  @override
  _PetWidgetState createState() => _PetWidgetState();
}

class _PetWidgetState extends State<PetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
    );
  }
}
