import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news/bloc/article_bloc.dart';
import 'package:news/bloc/article_event.dart';
import 'package:news/bloc/article_state.dart';
import 'package:news/data/constants.dart';
import 'package:news/data/model/articles.dart';
import 'package:news/data/repository/article_repository.dart';
import 'package:mockito/mockito.dart';

class MockArticleRepository extends Mock implements ArticleRepository {}

void main() {
  MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
  });

  group('FetchArticles', () {
    final newsResponseModel = NewsResponseModel().articles;

    blocTest(
      'emits [ ArticleLoadedState ] when successful',
      build: () {
        when(mockArticleRepository.getArticles(Constants.getUrl(1)))
            .thenAnswer((_) async => newsResponseModel);
        return ArticleBloc(repository: mockArticleRepository);
      },

      act: (bloc) => bloc.add(FetchArticlesEvent()),
      expect: [
        ArticleLoadedState(),
      ]
    );

    blocTest(
        'emits [ ErrorState  ] when successful',
        build: () {
          when(mockArticleRepository.getArticles(Constants.getUrl(1)))
              .thenThrow(Exception());
          return ArticleBloc(repository: mockArticleRepository);
        },

        act: (bloc) => bloc.add(FetchArticlesEvent()),
        expect: [
          ArticleErrorState(),
        ]
    );

  });
}
