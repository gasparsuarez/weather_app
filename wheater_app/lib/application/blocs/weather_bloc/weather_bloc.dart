import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wheater_app/domain/entities/weather_entity.dart';
import 'package:wheater_app/domain/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final IWeatherRepository iWeatherRepository;
  WeatherBloc(this.iWeatherRepository) : super(WeatherState()) {
    on<LoadWeatherEvent>((event, emit) async {
      try {
        emit(LoadingWeatherState());
        WeatherEntity weatherEntity =
            await iWeatherRepository.getCurrentWeather(event.locationName);
        emit(LoadedWeatherState(weatherEntity: weatherEntity));
      } catch (e) {
        emit(ErrorWeatherState(e.toString()));
      }
    });
  }
}
