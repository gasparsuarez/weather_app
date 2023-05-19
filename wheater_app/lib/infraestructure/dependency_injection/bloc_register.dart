import 'package:injector/injector.dart';
import 'package:wheater_app/application/blocs/weather_bloc/weather_bloc.dart';
import 'package:wheater_app/domain/repositories/weather_repository.dart';

class BlocRegister {
  final injector = Injector.appInstance;

  BlocRegister() {
    injector.registerSingleton<WeatherBloc>(
      () {
        return WeatherBloc(
          injector.get<IWeatherRepository>(),
        );
      },
    );
  }
}
