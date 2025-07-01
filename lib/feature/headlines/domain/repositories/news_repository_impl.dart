

import 'package:dailypulsenews/feature/headlines/data/datasources/news_api_service.dart';
import 'package:dailypulsenews/feature/headlines/data/models/article_model.dart';
import 'package:dailypulsenews/feature/headlines/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements INewsRepository {
  final NewsApiService service;

  NewsRepositoryImpl(this.service);

  @override
  Future<List<Article>> getTopHeadlines(String country) {
    return service.fetchTopHeadlines(country);
  }
}
