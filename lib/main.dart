
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/simple_bloc_observer.dart';
import 'package:news/ui/home_page.dart';

import 'bloc/article_bloc.dart';
import 'data/repository/article_repository.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      home: BlocProvider(
        create: (context) => ArticleBloc(repository: ArticleRepository()),
        child: HomePage(),
      ),
    );
  }
}