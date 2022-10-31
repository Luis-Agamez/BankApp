import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../global/enviroments.dart';
import '../../models/climate_response.dart';
import 'package:http/http.dart' as http;

import '../../models/prediction_clime.dart';

part 'clime_event.dart';
part 'clime_state.dart';

class ClimeBloc extends Bloc<ClimeEvent, ClimeState> {
  ClimeBloc() : super(const ClimeState()) {
    on<SetClimeEvent>((event, emit) {
      final clime = [...state.clime, event.clime];
      emit(state.copyWith(clime: clime));
    });

    on<SetClimePredictionEvent>((event, emit) {
      final climePrediction = [
        ...state.climePredictions,
        event.climePredictions
      ];
      emit(state.copyWith(climePredictions: climePrediction));
    });
  }

  void getClime(String latitude, String longitude) async {
    final uri = Uri.parse(
        '${Environment.apiUrlBase}?lat=$latitude&lon=$longitude&appid=${Environment.apiKeyClime}&units=metric');
    if (latitude.isNotEmpty && longitude.isNotEmpty) {
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (resp.statusCode == 200) {
        final climeResponse = ClimateResponse.fromJson(resp.body);
        add(SetClimeEvent(climeResponse));
      }
    }
  }

  void getClimePredictions(String latitude, String longitude) async {
    final uri = Uri.parse(
        '${Environment.apiUrlPredictions}?lat=$latitude&lon=$longitude&appid=${Environment.apiKey}&units=metric');
    if (latitude.isNotEmpty && longitude.isNotEmpty) {
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (resp.statusCode == 200) {
        final predictionResponse = PredictionResponse.fromJson(resp.body);
        final list = predictionResponse.list;
        add(SetClimePredictionEvent(predictionResponse));
      }
    }
  }
}
