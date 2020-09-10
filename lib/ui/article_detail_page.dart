import 'package:flutter/material.dart';
import 'package:news/data/model/articles.dart';

class ArticleDetailPage extends StatelessWidget {
  Articles article;

  ArticleDetailPage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Info"),
      ),
      body: ListView(
        padding: EdgeInsets.all(5.0),
        children: <Widget>[
          Hero(
            tag: article.urlToImage,
            child: Image.network(article.urlToImage),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: Text(
              article.title,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.all(5.0),
            child: Text(article.publishedAt),
          ),
          Text(article.content),
        ],
      ),
    );
  }
}
