import 'package:injector/injector.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

import '../../application/blocs/blocs.dart';

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
    injector.registerSingleton<SearchBloc>(
      () {
        return SearchBloc(injector.get<IWeatherRepository>());
      },
    );
    injector.registerSingleton<RecentBloc>(
      () {
        return RecentBloc();
      },
    );
    injector.registerSingleton<TemperatureBloc>(
      () {
        return TemperatureBloc();
      },
    );
  }
}
