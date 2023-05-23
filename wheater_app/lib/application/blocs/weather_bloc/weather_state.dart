part of 'weather_bloc.dart';

@immutable
class WeatherState {}

class LoadingWeatherState extends WeatherState {}

class LoadedWeatherState extends WeatherState {
  //final WeatherEntity weatherEntity;
  final ForecastEntity forecastEntity;
  LoadedWeatherState({required this.forecastEntity});

  LoadedWeatherState copyWith({ForecastEntity? forecastEntity}) =>
      LoadedWeatherState(forecastEntity: forecastEntity ?? this.forecastEntity);
}

class ErrorWeatherState extends WeatherState {
  final String error;
  ErrorWeatherState(this.error);
}
