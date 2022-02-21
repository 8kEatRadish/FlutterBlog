import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBottomWidget extends StatelessWidget {
  const HomeBottomWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 100,
      color: Colors.yellow,
    );
  }
}
