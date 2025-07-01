import 'package:dailypulsenews/feature/headlines/data/models/article_model.dart';

abstract class INewsRepository {
  Future<List<Article>> getTopHeadlines(String country);
}