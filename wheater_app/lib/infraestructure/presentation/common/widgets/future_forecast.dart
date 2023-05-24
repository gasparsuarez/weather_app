import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/styles.dart';

import '../../../../application/blocs/weather_bloc/weather_bloc.dart';

class ForecastInfo extends StatelessWidget {
  const ForecastInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.95,
        height: size.height * 0.17,
        decoration: boxContentDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is LoadingWeatherState) {
                  return _circularProgressIndicator();
                } else if (state is LoadedWeatherState) {
                  final forecast = state.forecastEntity.forecast.forecastday;
                  return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: forecast.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return _ForecastBox(index: index);
                      });
                } else if (state is ErrorWeatherState) {
                  return _circularProgressIndicator();
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ));
  }

  Widget _circularProgressIndicator() {
    return const Center(
        child: CircularProgressIndicator(
      strokeWidth: 2,
      color: Colors.white,
    ));
  }
}

class _ForecastBox extends StatelessWidget {
  final int index;
  const _ForecastBox({required this.index});

  @override
  Widget build(BuildContext context) {
    final List<String> weekDays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    const textStyle = TextStyle(color: Colors.white);
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is LoadedWeatherState) {
          final forecast = state.forecastEntity.forecast.forecastday[index];
          return SizedBox(
              width: 100,
              height: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(weekDays[forecast.date.weekday - 1], style: textStyle),
                  const SizedBox(height: 3),
                  Image.network('https:${forecast.day.condition.icon}'),
                  const SizedBox(height: 3),
                  Text('Max: ${forecast.day.maxtempC}', style: textStyle),
                  Text('Min: ${forecast.day.mintempC}', style: textStyle)
                ],
              ));
        }
        return const CircularProgressIndicator(strokeWidth: 2);
      },
    );
  }
}
