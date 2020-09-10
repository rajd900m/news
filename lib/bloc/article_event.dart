import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchArticlesEvent extends ArticleEvent {}