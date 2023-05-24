import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wheater_app/domain/entities/forecast_entity.dart';
import 'package:wheater_app/domain/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final IWeatherRepository iWeatherRepository;
  WeatherBloc(this.iWeatherRepository) : super(WeatherState()) {
    on<LoadWeatherEvent>((event, emit) async {
      emit(LoadingWeatherState());
      try {
        final forecastEntity = await iWeatherRepository.getCurrentForecast(event.locationName);
        emit(LoadedWeatherState(forecastEntity: forecastEntity));
      } catch (e) {
        emit(ErrorWeatherState('Ingrese una ubicación válida.'));
      }
    });
  }
}
