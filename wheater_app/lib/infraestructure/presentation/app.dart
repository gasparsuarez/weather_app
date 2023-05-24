import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/config/routes/router.dart';
import '../../application/blocs/weather_bloc/weather_bloc.dart';
import '../../config/theme/app_theme.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => Injector.appInstance.get<WeatherBloc>()
              ..add(LoadWeatherEvent(locationName: 'Argentina'))),
      ],
      child: MaterialApp.router(
        routerConfig: routes,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
      ),
    );
  }
}
