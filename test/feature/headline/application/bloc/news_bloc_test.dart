import 'package:bloc_test/bloc_test.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/core/storage/preferences_helper.dart';
import 'package:dailypulsenews/feature/headlines/headlines.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dailypulsenews/feature/headlines/domain/repositories/news_repository.dart';
import 'package:dailypulsenews/feature/headlines/data/models/article_model.dart';

class MockNewsRepository extends Mock implements INewsRepository {}

class MockPreferencesHelper extends Mock implements PreferencesHelper {}

void main() {
  late NewsBloc bloc;
  late MockNewsRepository mockRepo;
  late MockPreferencesHelper mockPrefs;

  const testCountry = 'US';

  const mockArticle = Article(
    source: Source(id: 'cnn', name: 'CNN'),
    author: 'Reporter',
    title: 'News Title',
    description: 'News description',
    url: 'https://news.com/article',
    urlToImage: 'https://news.com/image.jpg',
    publishedAt: '2025-07-01T00:00:00Z',
    content: 'Content',
  );

  setUp(() {
    mockRepo = MockNewsRepository();
    mockPrefs = MockPreferencesHelper();

    bloc = NewsBloc(mockRepo, mockPrefs);
  });

  group('NewsBloc Tests', () {
    blocTest<NewsBloc, NewsState>(
      'emits [loading, success] on FetchHeadlines',
      build: () {
        when(() => mockRepo.getTopHeadlines(testCountry))
            .thenAnswer((_) async => [mockArticle]);
        return bloc;
      },
      act: (bloc) => bloc.add(const NewsEvent.fetchHeadlines(country: testCountry)),
      expect: () => [
        NewsState(loading: true),
        NewsState(
          loading: false,
          articles: [mockArticle],
          articlesEitherFailureOrUnit: some(right(unit)),
        ),
      ],
    );

    blocTest<NewsBloc, NewsState>(
      'emits [loading, error] on FetchHeadlines failure',
      build: () {
        when(() => mockRepo.getTopHeadlines(testCountry))
            .thenThrow(Exception('Fetch failed'));
        return bloc;
      },
      act: (bloc) => bloc.add(const NewsEvent.fetchHeadlines(country: testCountry)),
      expect: () => [
        NewsState(loading: true),
        NewsState(
          loading: false,
          articles: [],
          articlesEitherFailureOrUnit: some(left(Failure(message: 'Exception: Fetch failed'))),
        ),
      ],
    );

    blocTest<NewsBloc, NewsState>(
      'emits country code and triggers FetchHeadlines on LoadPreferredCountry',
      build: () {
        when(() => mockPrefs.load()).thenAnswer((_) async => testCountry);
        when(() => mockRepo.getTopHeadlines(testCountry))
            .thenAnswer((_) async => [mockArticle]);
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadPreferredCountry()),
      expect: () => [
        NewsState(selectedCountry: testCountry),
        NewsState(
          selectedCountry: testCountry,
          loading: true,
        ),
        NewsState(
          selectedCountry: testCountry,
          loading: false,
          articles: [mockArticle],
          articlesEitherFailureOrUnit: some(right(unit)),
        ),
      ],
    );

    blocTest<NewsBloc, NewsState>(
      'calls prefs.save and fetches new headlines on SetPreferredCountry',
      build: () {
        when(() => mockPrefs.save(testCountry))
            .thenAnswer((_) async {});
        when(() => mockRepo.getTopHeadlines(testCountry))
            .thenAnswer((_) async => [mockArticle]);
        return bloc;
      },
      act: (bloc) => bloc.add(const SetPreferredCountry(country: testCountry)),
      expect: () => [
        NewsState(loading: true),
        NewsState(
          loading: false,
          articles: [mockArticle],
          articlesEitherFailureOrUnit: some(right(unit)),
        ),
      ],
      verify: (_) {
        verify(() => mockPrefs.save(testCountry)).called(1);
        verify(() => mockRepo.getTopHeadlines(testCountry)).called(1);
      },
    );
  });
}