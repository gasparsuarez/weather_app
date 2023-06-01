import 'package:injector/injector.dart';
import 'package:wheater_app/application/blocs/weather_bloc/weather_bloc.dart';
import 'package:wheater_app/domain/repositories/weather_repository.dart';

import '../../application/blocs/recents_bloc/recent_bloc.dart';
import '../../application/blocs/search_bloc/search_bloc.dart';
import '../../application/blocs/temperature_bloc/temperature_bloc.dart';

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
