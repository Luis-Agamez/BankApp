import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid ? '' : '';

  static String apiUrlPredictions = '';

  static String apiKeyClime = '';

  static String apiUrlBase = Platform.isAndroid ? '' : '';
  static String apiKey = '';
}
