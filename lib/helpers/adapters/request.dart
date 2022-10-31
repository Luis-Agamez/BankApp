import 'package:http/http.dart' as http;
import '../../global/enviroments.dart';

/* void getClime(String latitude, String longitude) async {
    final uri = Uri.parse(
        '${Environment.apiUrlBase}?lat=$latitude&lon=$longitude&appid=${Environment.apiKey}&units=metric');
    if (latitude.isNotEmpty && longitude.isNotEmpty) {
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      // print(resp.body);
      if (resp.statusCode == 200) {
        final climeResponse = ClimateResponse.fromJson(resp.body);
        add(SetClimeEvent(climeResponse));
        if (climeResponse.weather[0].main == 'Rain') {}
      }
    }
  } */