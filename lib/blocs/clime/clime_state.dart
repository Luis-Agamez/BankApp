part of 'clime_bloc.dart';

class ClimeState extends Equatable {
  final List<ClimateResponse> clime;
  final List<PredictionResponse> climePredictions;

  const ClimeState({this.clime = const [], this.climePredictions = const []});

  ClimeState copyWith(
          {List<ClimateResponse>? clime,
          List<PredictionResponse>? climePredictions}) =>
      ClimeState(
        clime: clime ?? this.clime,
        climePredictions: climePredictions ?? this.climePredictions,
      );

  @override
  List<Object> get props => [clime, climePredictions];
}
