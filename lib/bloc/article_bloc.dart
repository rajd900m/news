import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:news/data/constants.dart';
import 'package:news/data/model/articles.dart';
import 'package:news/data/repository/article_repository.dart';

import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;

  ArticleBloc({@required this.repository}) : super(ArticleInitialState());

  @override
  Stream<Transition<ArticleEvent, ArticleState>> transformEvents(
      Stream<ArticleEvent> events, transitionFn) {
    // TODO: implement transformEvents
    return super.transformEvents(events, transitionFn);
  }

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    final currentState = state;
    if (event is FetchArticlesEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ArticleInitialState) {
          List<Articles> articles =
              await repository.getArticles(Constants.getUrl(1));
          yield ArticleLoadedState(articles: articles, hasReachedMax:  false);
          return;
        }
        if (currentState is ArticleLoadedState) {
          List<Articles> articles =
              await repository.getArticles(Constants.getUrl(2));
          yield ArticleLoadedState(
              articles: currentState.articles + articles, hasReachedMax: true);
        }
      } catch (e) {
        yield ArticleErrorState(message: e.toString());
      }
    }
  }

  bool _hasReachedMax(ArticleState state) {
    if (state is ArticleLoadedState) {
      return state.hasReachedMax;
    } else {
      return false;
    }
  }
}
