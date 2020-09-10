import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news/data/model/articles.dart';

class ArticleRepository {
  @override
  Future<List<Articles>> getArticles(String url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) ;
      List<Articles> articles = NewsResponseModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}
