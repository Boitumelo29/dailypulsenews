import 'package:dailypulsenews/core/env/env.dart';
import 'package:dailypulsenews/core/storage/preferences_helper.dart';
import 'package:dailypulsenews/feature/headlines/application/bloc/news_bloc.dart';
import 'package:dailypulsenews/feature/headlines/data/datasources/news_api_service.dart';
import 'package:dailypulsenews/feature/headlines/domain/repositories/news_repository.dart';
import 'package:dailypulsenews/feature/headlines/domain/repositories/news_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  final dio = Dio();
  getIt.registerLazySingleton<PreferencesHelper>(() => PreferencesHelper());

  getIt.registerSingleton<NewsApiService>(
    NewsApiService(dio, apiKey: Env.newsApiKey),
  );

  getIt.registerSingleton<INewsRepository>(
    NewsRepositoryImpl(getIt<NewsApiService>()),
  );

  getIt.registerFactory(() => NewsBloc(
        getIt<INewsRepository>(),
        getIt<PreferencesHelper>(),
      ));
}
