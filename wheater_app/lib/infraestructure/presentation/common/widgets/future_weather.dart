import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/styles.dart';

import '../../../../application/blocs/blocs.dart';

class ForecastInfo extends StatelessWidget {
  const ForecastInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.95,
        height: size.height * 0.25,
        decoration: boxContentDecoration,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text('Pronóstico de 13 días',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            const Divider(color: Colors.blueGrey),
            SizedBox(
              width: size.width * 0.95,
              height: size.height * 0.17,
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is LoadingWeatherState) {
                    return _circularProgressIndicator();
                  } else if (state is LoadedWeatherState) {
                    final dateToday = DateTime.now();
                    final dateRemoveOfList =
                        DateTime(dateToday.year, dateToday.month, dateToday.day);
                    final forecast = state.forecastEntity.forecast.forecastday
                      ..removeWhere((element) => element.date == dateRemoveOfList);
                    return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: forecast.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          return FadeInLeft(
                              duration: const Duration(seconds: 2),
                              child: _ForecastBoxInfo(
                                  weekDay: forecast[index].date.weekday,
                                  day: forecast[index].date.day,
                                  maxTempC: forecast[index].day.maxtempC,
                                  minTempC: forecast[index].day.mintempC,
                                  maxTempF: forecast[index].day.maxtempF,
                                  minTempF: forecast[index].day.mintempF,
                                  icon: forecast[index].day.condition.icon));
                        });
                  } else if (state is ErrorWeatherState) {
                    return _circularProgressIndicator();
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
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

class _ForecastBoxInfo extends StatelessWidget {
  final int weekDay;
  final int day;
  final double maxTempC;
  final double minTempC;
  final double maxTempF;
  final double minTempF;
  final String icon;

  const _ForecastBoxInfo(
      {required this.weekDay,
      required this.day,
      required this.maxTempC,
      required this.minTempC,
      required this.maxTempF,
      required this.minTempF,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final List<String> days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    const textStyle = TextStyle(color: Colors.white);
    return BlocBuilder<TemperatureBloc, TemperatureState>(
      builder: (context, state) {
        return SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(days[weekDay - 1], style: textStyle),
                Text('$day', style: textStyle),
                Image.network('https:$icon'),
                const SizedBox(height: 3),
                Text(state.isF ? 'Máx: $maxTempF°' : 'Máx: $maxTempC°', style: textStyle),
                Text(state.isF ? 'Mín: $minTempF°' : 'Mín: $minTempC°', style: textStyle)
              ],
            ));
      },
    );
  }
}
