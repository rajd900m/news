import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/article_bloc.dart';
import 'package:news/bloc/article_event.dart';
import 'package:news/bloc/article_state.dart';
import 'package:news/data/model/articles.dart';

import 'article_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollTreshold = 200.0;
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("News"),
              ),
              body: Container(
                child: BlocListener<ArticleBloc, ArticleState>(
                  listener: (context, state) {
                    if (state is ArticleErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      if (state is ArticleInitialState) {
                        return buildLoading();
                      } else if (state is ArticleLoadingState) {
                        return buildLoading();
                      } else if (state is ArticleLoadedState) {
                        return buildArticleList(state);
                      } else if (state is ArticleErrorState) {
                        return buildErrorUi(state.message);
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(ArticleLoadedState state) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return position >= state.articles.length
            ? BottomLoader()
            : ListItem(article: state.articles[position]);
      },
      itemCount: state.hasReachedMax
          ? state.articles.length
          : state.articles.length + 1,
      controller: _scrollController,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollTreshold) {
      articleBloc.add(FetchArticlesEvent());
    }
  }
} //end of home page state

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 35,
          height: 35,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Articles article;

  const ListItem({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("image url is ${article.urlToImage}");
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Hero(
            tag: article.urlToImage,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/error.png',
              image: article.urlToImage,
              fit: BoxFit.cover,
              height: 100.0,
              width: 60.0,
            ),
          ),
        ),
        title: Text(article.title),
        subtitle: Text(article.publishedAt),
      ),
    );
  }
}
