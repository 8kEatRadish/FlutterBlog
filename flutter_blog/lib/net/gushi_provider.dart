import 'package:flutter_blog/net/model/gushi_model.dart';
import 'package:get/get.dart';

import 'net_utils.dart';

class GushiProvider {
  Future<GushiModel> getGushi() async {
    var response = await NetUtil.getInstance().get('https://v1.jinrishici.com/all.json');
    var data = GushiModel.fromJson(response);
    return data;
  }
}
