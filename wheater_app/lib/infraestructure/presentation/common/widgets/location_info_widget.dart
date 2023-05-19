import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/infraestructure/presentation/common/config/theme/app_theme.dart';

import '../../../../application/blocs/weather_bloc/weather_bloc.dart';

class LocationInfoWidget extends StatelessWidget {
  const LocationInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
            colors: [gFirstColor, gSecondColor, gThirdColor],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: 220,
        height: 70,
        decoration: boxDecoration,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is LoadingWeatherState) {
              return _circleProgressIndicator();
            } else if (state is LoadedWeatherState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.weatherEntity.location.name,
                      style: const TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(width: 10),
                  Text(
                    '${state.weatherEntity.location.region}, ${state.weatherEntity.location.country}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
            return _circleProgressIndicator();
          },
        ),
      ),
    );
  }

  _circleProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      ),
    );
  }
}
