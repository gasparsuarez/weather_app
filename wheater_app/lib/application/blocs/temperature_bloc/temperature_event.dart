part of 'temperature_bloc.dart';

abstract class TemperatureEvent extends Equatable {
  const TemperatureEvent();

  @override
  List<Object> get props => [];
}

class ChangeTempEvent extends TemperatureEvent {
  final bool isF;
  const ChangeTempEvent({required this.isF});
}
