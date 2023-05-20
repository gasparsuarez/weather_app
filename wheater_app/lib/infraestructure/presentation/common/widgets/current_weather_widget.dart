import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/condition_detail_util.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/styles.dart';

import '../../../../application/blocs/weather_bloc/weather_bloc.dart';
import '../../../../domain/entities/condition_entity.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.9,
        height: size.height * 0.15,
        decoration: boxContentDecoration,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is LoadingWeatherState) {
              return Center(child: _circleProgressIndicator());
            } else if (state is LoadedWeatherState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _ActualCondition(),
                  _ActualConditionData(),
                ],
              );
            } else if (state is ErrorWeatherState) {
              return Center(child: _circleProgressIndicator());
            }
            return const Text('');
          },
        ));
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

class _ActualConditionData extends StatelessWidget {
  const _ActualConditionData();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);
    const tempStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white);
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is LoadedWeatherState) {
          final condition = state.weatherEntity.current;
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Viento: ${condition.windKph} kph', style: textStyle),
                  Text('Precip: ${condition.precipMm} mm', style: textStyle),
                  Text('Presión: ${condition.pressureMb} mb', style: textStyle),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('${condition.tempC} °C', style: tempStyle)],
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ActualCondition extends StatelessWidget {
  const _ActualCondition();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is LoadedWeatherState) {
          final ConditionEntity condition = ConditionUtil.getCondition(
              isDay: state.weatherEntity.current.isDay == 1 ? true : false,
              code: state.weatherEntity.current.condition.code);
          return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                        child: condition.isDay
                            ? Image.asset(
                                'assets/weather/day/${condition.iconCode}.png',
                                scale: 0.8,
                              )
                            : Image.asset('assets/weather/night/${condition.iconCode}.png',
                                scale: 1)),
                    SizedBox(
                        child: Text(
                      condition.text,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 2,
                    )),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
