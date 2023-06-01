import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/domain/repositories/weather_repository.dart';

import '../../../domain/entities/forecast_entity.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final IWeatherRepository _iWeatherRepository;
  WeatherBloc(this._iWeatherRepository) : super(WeatherState()) {
    on<LoadWeatherEvent>((event, emit) async {
      emit(LoadingWeatherState());
      final currentForecast = await _iWeatherRepository.getCurrentForecast(event.locationName);
      currentForecast.when(
          (currentForecast) => emit(LoadedWeatherState(forecastEntity: currentForecast)),
          (exception) => emit(ErrorWeatherState(exception.toString())));
    });
  }
}
