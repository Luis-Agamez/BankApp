import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.1.15:3000/api'
      : 'localhost:4000/api/auth';

  static String apiUrlPredictions =
      'https://api.openweathermap.org/data/2.5/forecast';

  static String apiKeyClime = '0de7206f15a4484749621d1196600af1';

  static String apiUrlBase = Platform.isAndroid
      ? 'https://api.openweathermap.org/data/2.5/weather'
      : 'https://api.openweathermap.org/data/2.5/weather';
  static String apiKey = '0de7206f15a4484749621d1196600af1';
}
