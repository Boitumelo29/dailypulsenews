part of 'news_bloc.dart';

@freezed
abstract class NewsState with _$NewsState {
  factory NewsState({
    @Default(false) bool loading,
    @Default([]) List<Article> articles,
    @Default(None()) Option<Either<Failure, Unit>> articlesEitherFailureOrUnit,
  }) = _NewsState;
}
