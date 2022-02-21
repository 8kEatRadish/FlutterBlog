import 'package:flutter/material.dart';
import 'package:flutter_blog/net/gushi_provider.dart';
import 'package:flutter_blog/net/model/gushi_model.dart';
import 'package:get/get.dart';

class HomeGushiWidget extends StatefulWidget {
  const HomeGushiWidget({Key key}) : super(key: key);

  @override
  _HomeGushiWidgetState createState() => _HomeGushiWidgetState();
}

class _HomeGushiWidgetState extends State<HomeGushiWidget> {
  Future<GushiModel> _calculation = GushiProvider().getGushi();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 300,
      child: FutureBuilder<GushiModel>(
          future: _calculation,
          builder: (BuildContext context, AsyncSnapshot<GushiModel> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.only(top: 100, bottom: 100),
                child: Column(
                  children: [
                    Center(
                      child: Text(snapshot.data.content),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("----"),
                        Text("《${snapshot.data.origin}》"),
                        Text("  ${snapshot.data.author}")
                      ],
                    )
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
