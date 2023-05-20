import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/styles.dart';

import '../../../../application/blocs/weather_bloc/weather_bloc.dart';

class LocationInfoWidget extends StatelessWidget {
  const LocationInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: size.width * 0.9,
        height: 70,
        decoration: boxContentDecoration,
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
