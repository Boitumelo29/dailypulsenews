import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
@envied
abstract class Env {
  @EnviedField(varName: 'API_URL', obfuscate: true)
  static  String apiURL = _Env.apiURL;

  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static  String apiKey = _Env.apiKey;

  @EnviedField(varName: 'NEWS_API_KEY', obfuscate: true)
  static  String newsApiKey = _Env.newsApiKey;

  @EnviedField(varName: 'NEWS_API_URL', obfuscate: true)
  static  String newsApiUrl = _Env.newsApiUrl;
}
