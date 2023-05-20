part of 'weather_bloc.dart';

@immutable
class WeatherState {}

class LoadingWeatherState extends WeatherState {}

class LoadedWeatherState extends WeatherState {
  final WeatherEntity weatherEntity;
  LoadedWeatherState({required this.weatherEntity});

  LoadedWeatherState copyWith({WeatherEntity? weatherEntity, String? locationName}) =>
      LoadedWeatherState(weatherEntity: weatherEntity ?? this.weatherEntity);
}

class ErrorWeatherState extends WeatherState {
  final String error;
  ErrorWeatherState(this.error);
}
