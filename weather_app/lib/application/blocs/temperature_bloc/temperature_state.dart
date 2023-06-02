part of 'temperature_bloc.dart';

class TemperatureState extends Equatable {
  final bool isF;
  const TemperatureState({this.isF = false});

  TemperatureState copyWith({bool? isF}) => TemperatureState(isF: isF ?? this.isF);

  @override
  List<Object> get props => [isF];
}

class TemperatureInitial extends TemperatureState {}
