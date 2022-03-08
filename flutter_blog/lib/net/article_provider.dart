import 'package:dio/dio.dart';
import 'package:flutter_blog/article/model/article_model.dart';

import 'net_utils.dart';

class ArticleProvider {
  Future<List<ArticleModel>> getArticle() async {
    var response = await NetUtil.getInstance()
        .get('https://ihe54b9i.lc-cn-n1-shared.com/1.1/classes/articel',
        options: Options(headers: {
          "X-LC-Id": "IHE54b9isrXQs6TH144U5NKW-gzGzoHsz",
          "X-LC-Key": "BE3SDERpNdwPA8Btpfvcp4Yr"
        }));
    var result = Results.fromJson(response);
    print("size = ${result.results.length}");
    return result.results;
  }
}
