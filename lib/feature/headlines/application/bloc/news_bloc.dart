import 'package:bloc/bloc.dart';
import 'package:dailypulsenews/core/core.dart';
import 'package:dailypulsenews/core/storage/preferences_helper.dart';
import 'package:dailypulsenews/feature/headlines/data/models/article_model.dart';
import 'package:dailypulsenews/feature/headlines/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_event.dart';

part 'news_state.dart';

part 'news_bloc.freezed.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final INewsRepository repository;
  final PreferencesHelper prefs;

  NewsBloc(this.repository, this.prefs) : super(NewsState()) {
    on<FetchHeadlines>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));
        final articles = await repository.getTopHeadlines(event.country);
        emit(state.copyWith(
            articles: articles,
            loading: false,
            articlesEitherFailureOrUnit: some(right(unit))));
      } catch (e) {
        emit(state.copyWith(
            loading: false,
            articlesEitherFailureOrUnit:
                some(left(Failure(message: e.toString())))));
      }
    });
    on<LoadPreferredCountry>((event, emit) async {
      final code = await prefs.load();
      emit(state.copyWith(selectedCountry: code));
      add(NewsEvent.fetchHeadlines(country: code));
    });

    on<SetPreferredCountry>((event, emit) async {
      await prefs.save(event.country);
      add(NewsEvent.fetchHeadlines(country: event.country));
    });
  }
}
