// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog/markdown/markdown_toc.dart';
import 'package:flutter_blog/markdown/markdown_widget.dart';
import 'package:flutter_blog/utils/config.dart';
import 'package:flutter_blog/utils/util.dart';
import 'package:flutter_blog/widget/square_grid_scale_loading.dart';

class MarkdownPage extends StatefulWidget {
  final String assetsPath;
  final String markdownData;

  const MarkdownPage(
      {Key key, this.assetsPath = AssetsUtils.article, this.markdownData})
      : assert(assetsPath != null || markdownData != null),
        super(key: key);

  @override
  _MarkdownPageState createState() => _MarkdownPageState();
}

class _MarkdownPageState extends State<MarkdownPage> {
  ///key: [isEnglish] , value: data
  Map<bool, String> dataMap = {};
  String data;
  final TocController controller = TocController();
  bool isEnglish = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadData(String assetsPath) async {
    if (dataMap[isEnglish] != null) {
      data = dataMap[isEnglish];
    } else {
      var data = await rootBundle.loadString(assetsPath);
      dataMap[isEnglish] = data;
      this.data = data;
    }
    await Future.delayed(Duration(milliseconds: 2000));
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadData(widget.assetsPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return buildWebBody();
          } else {
            return Center(
              child: SquareGridScaleLoading(
                color: Color(0xff697e9d),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildTocList() => TocListWidget(
        controller: controller,
        key: ValueKey(controller),
      );

  Widget buildMarkdown() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: MarkdownWidget(
        data: data,
        controller: controller,
        styleConfig: StyleConfig(
            pConfig: PConfig(
                linkGesture: (linkChild, url) {
                  return GestureDetector(
                    child: linkChild,
                    onTap: () => launchURL(url),
                  );
                },
                selectable: false),
            preConfig: PreConfig(
              preWrapper: (child, text) =>
                  buildCodeBlock(child, text, isEnglish),
            ),
            tableConfig: TableConfig(
              defaultColumnWidth: FixedColumnWidth(50),
              headChildWrapper: (child) => Container(
                margin: EdgeInsets.all(10.0),
                child: child,
                alignment: Alignment.center,
              ),
              bodyChildWrapper: (child) => Container(
                margin: EdgeInsets.all(10.0),
                child: child,
                alignment: Alignment.center,
              ),
            ),
            markdownTheme: MarkdownTheme.lightTheme),
      ),
    );
  }

  Widget buildCodeBlock(Widget child, String text, bool isEnglish) {
    return Stack(
      children: <Widget>[
        child,
        Container(
          margin: EdgeInsets.only(top: 5, right: 5),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              Widget toastWidget = Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff006EDF), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(
                        4,
                      )),
                      color: Color(0xff007FFF)),
                  width: 150,
                  height: 40,
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        isEnglish ? 'Copy successful' : '复制成功',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.content_copy,
              size: 10,
            ),
          ),
        )
      ],
    );
  }

  Widget buildWebBody() {
    return Row(
      children: <Widget>[
        Expanded(child: buildTocList()),
        Expanded(
          child: buildMarkdown(),
          flex: 3,
        )
      ],
    );
  }
}
