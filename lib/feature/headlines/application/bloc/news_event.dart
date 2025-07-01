part of 'news_bloc.dart';

@freezed
class NewsEvent with _$NewsEvent {
  const factory NewsEvent.started() = _Started;
  const factory NewsEvent.fetchHeadlines({required String country}) = FetchHeadlines;
  const factory NewsEvent.loadPreferredCountry() = LoadPreferredCountry;
  const factory NewsEvent.setPreferredCountry({required String country}) = SetPreferredCountry;

}
