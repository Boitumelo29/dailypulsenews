

import 'package:dailypulsenews/core/env/env.dart';
import 'package:dailypulsenews/feature/headlines/data/models/article_model.dart';
import 'package:dio/dio.dart';

class NewsApiService {
  final Dio dio;
  final String apiKey;

  NewsApiService(this.dio, {required this.apiKey});

  Future<List<Article>> fetchTopHeadlines(String country) async {
    final response = await dio.get(
     Env.newsApiUrl,
      queryParameters: {
        'country': country,
        'apiKey': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final articles = (response.data['articles'] as List)
          .map((json) => Article.fromJson(json))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load news');
    }
  }
}