part of 'clime_bloc.dart';

abstract class ClimeEvent extends Equatable {
  const ClimeEvent();

  @override
  List<Object> get props => [];
}

class SetClimeEvent extends ClimeEvent {
  final ClimateResponse clime;

  const SetClimeEvent(this.clime);
}

class SetClimePredictionEvent extends ClimeEvent {
  final PredictionResponse climePredictions;
  const SetClimePredictionEvent(this.climePredictions);
}
