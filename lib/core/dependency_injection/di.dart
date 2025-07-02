import 'package:dailypulsenews/core/env/env.dart';
import 'package:dailypulsenews/core/storage/preferences_helper.dart';
import 'package:dailypulsenews/feature/auth/application/bloc/auth_bloc.dart';
import 'package:dailypulsenews/feature/headlines/application/bloc/news_bloc.dart';
import 'package:dailypulsenews/feature/headlines/data/datasources/news_api_service.dart';
import 'package:dailypulsenews/feature/headlines/domain/repositories/news_repository.dart';
import 'package:dailypulsenews/feature/headlines/domain/repositories/news_repository_impl.dart';
import 'package:dailypulsenews/feature/user/user_registration/application/bloc/user_registration_bloc.dart';
import 'package:dailypulsenews/feature/user/user_registration/data/firebase_auth_service.dart';
import 'package:dailypulsenews/feature/user/user_registration/domain/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  final dio = Dio();
  getIt.registerLazySingleton<PreferencesHelper>(() => PreferencesHelper());

  getIt.registerSingleton<NewsApiService>(
    NewsApiService(dio, apiKey: Env.newsApiKey),
  );

  getIt.registerSingleton<IAuthRepository>(FirebaseAuthService());

  getIt.registerSingleton<INewsRepository>(
    NewsRepositoryImpl(getIt<NewsApiService>()),
  );

  getIt.registerFactory(() => NewsBloc(
        getIt<INewsRepository>(),
        getIt<PreferencesHelper>(),
      ));

  getIt.registerFactory(() => AuthBloc(
        getIt<IAuthRepository>(),
      ));

  getIt.registerFactory(() => UserRegistrationBloc(
        getIt<IAuthRepository>(),
      ));
}
