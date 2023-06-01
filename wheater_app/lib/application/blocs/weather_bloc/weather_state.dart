part of 'weather_bloc.dart';

class WeatherState {}

class LoadingWeatherState extends WeatherState {}

class LoadedWeatherState extends WeatherState with EquatableMixin {
  final ForecastEntity forecastEntity;
  LoadedWeatherState({required this.forecastEntity});

  LoadedWeatherState copyWith({ForecastEntity? forecastEntity}) =>
      LoadedWeatherState(forecastEntity: forecastEntity ?? this.forecastEntity);
  @override
  List<Object?> get props => [forecastEntity];
}

class ErrorWeatherState extends WeatherState {
  final String error;
  ErrorWeatherState(this.error);
}
