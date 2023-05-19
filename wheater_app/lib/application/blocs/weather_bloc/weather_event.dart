part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class LoadWeatherEvent extends WeatherEvent {
  final String locationName;

  LoadWeatherEvent({required this.locationName});
}
