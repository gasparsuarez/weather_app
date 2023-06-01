part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {}

class LoadWeatherEvent extends WeatherEvent {
  final String locationName;

  LoadWeatherEvent({required this.locationName});

  @override
  List<Object?> get props => [locationName];
}
