import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news/data/model/articles.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

  @override
  List<Object> get props => [];

  @override
  bool operator ==(Object other) {
    return super == other;
  }
}

class ArticleInitialState extends ArticleState {}

class ArticleLoadingState extends ArticleState {}

class ArticleLoadedState extends ArticleState {
  final List<Articles> articles;
  final bool hasReachedMax;

  const ArticleLoadedState({this.articles, this.hasReachedMax});

  ArticleLoadedState copyWith({List<Articles> articles, bool hasReachedMax}) {
    return ArticleLoadedState(
        articles: articles ?? this.articles,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  // TODO: implement props
  List<Object> get props => [articles, hasReachedMax];

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

}

class ArticleErrorState extends ArticleState {
  String message;

  ArticleErrorState({@required this.message});


  @override
  // TODO: implement props
  List<Object> get props => [message];
}
