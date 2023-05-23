import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/styles.dart';

import '../../../../application/blocs/weather_bloc/weather_bloc.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is ErrorWeatherState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
              children: const [
                Icon(Icons.info_outline, color: Colors.white),
                SizedBox(width: 10),
                Text('Error de datos. Intente nuevamente..')
              ],
            )),
          );
        }
      },
      child: Container(
          width: size.width * 0.95,
          height: size.height * 0.20,
          decoration: boxContentDecoration,
          child: BlocBuilder<WeatherBloc, WeatherState>(
            buildWhen: (previous, current) => previous != current,
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
          )),
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

class _ActualConditionData extends StatelessWidget {
  const _ActualConditionData();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);
    const tempStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white);
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is LoadedWeatherState) {
          final condition = state.forecastEntity.current;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Viento: ${condition.windKph} kph', style: textStyle),
                  Text('Precip: ${condition.precipMm} mm', style: textStyle),
                  Text('Presión: ${condition.pressureMb} mb', style: textStyle),
                  Text('Humedad: ${condition.humidity} %', style: textStyle),
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
          final condition = state.forecastEntity.current.condition;
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.network(
                      'https:${condition.icon}',
                      scale: 0.7,
                    ),
                    SizedBox(
                        width: 150,
                        child: Text(
                          condition.text,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
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
