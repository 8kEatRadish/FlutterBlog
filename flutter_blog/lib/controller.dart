import 'package:flutter_blog/utils/config.dart';
import 'package:flutter_blog/utils/enums.dart';
import 'package:get/get.dart';

// 全局逻辑
class Controller extends GetxController {
  // 当前页面类型
  var pageType = PageType.web.obs;

  // 当前语言类型
  var languageType = TextTemplate.languageCn.obs;
}
