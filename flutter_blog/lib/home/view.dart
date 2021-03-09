import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logic.dart';
import 'state.dart';

class HomePage extends StatelessWidget {
  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get.find<HomeLogic>().state;

  ///加载页面
  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: FutureBuilder(
          future: rootBundle.loadString(
              'assets/markdown/基于ViewModel、LiveData的消息总线OneStepMessage.md'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: MarkdownBody(
                    styleSheet: MarkdownStyleSheet(
                        h1: GoogleFonts.oswald(
                            textStyle: Theme.of(context).textTheme.headline2),
                        code: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.bodyText1)),
                    data: snapshot.data,
                    onTapLink: (url, href, title) {
                      print("url = $url, \n href = $href , \n title = $title");
                      _launchURL(href);
                    },
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("Loading...",
                    style: GoogleFonts.oswald(
                        textStyle: Theme.of(context).textTheme.headline1)),
              );
            }
          }),
    );
  }
}
