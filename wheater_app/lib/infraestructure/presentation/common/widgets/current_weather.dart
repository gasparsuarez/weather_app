import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/styles.dart';

import '../../../../application/blocs/blocs.dart';

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
                padding: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                content: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.white),
                    const SizedBox(width: 10),
                    SizedBox(width: 330, child: Text(state.error, maxLines: 2))
                  ],
                )),
          );
        }
      },
      child: Container(
          width: size.width * 0.95,
          height: size.height * 0.20,
          decoration: boxContentDecoration,
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Text(
                'Condición actual',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Divider(color: Colors.blueGrey),
              SizedBox(
                width: size.width * 0.95,
                height: size.height * 0.14,
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is LoadingWeatherState) {
                      return Center(child: _circleProgressIndicator());
                    } else if (state is LoadedWeatherState) {
                      return FadeIn(
                        duration: const Duration(seconds: 2),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _ActualCondition(),
                            _ActualConditionData(),
                          ],
                        ),
                      );
                    } else if (state is ErrorWeatherState) {
                      return Center(child: _circleProgressIndicator());
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
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
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is LoadedWeatherState) {
          final condition = state.forecastEntity.current;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Viento: ${condition.windKph} km/h', style: bodyStyle),
                  Text('Precip: ${condition.precipMm} mm', style: bodyStyle),
                  Text('Presión: ${condition.pressureMb} mb', style: bodyStyle),
                  Text('Humedad: ${condition.humidity} %', style: bodyStyle),
                  const SizedBox(height: 5),
                  _CurrentTemperature(
                    tempC: condition.tempC,
                    tempF: condition.tempF,
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

class _CurrentTemperature extends StatelessWidget {
  final double tempC;
  final double tempF;
  const _CurrentTemperature({required this.tempC, required this.tempF});

  @override
  Widget build(BuildContext context) {
    const tempStyle = TextStyle(fontSize: 23, color: Colors.white);
    return BlocBuilder<TemperatureBloc, TemperatureState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.isF ? '$tempF° F' : '$tempC° C', style: tempStyle),
          ],
        );
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
                          maxLines: 4,
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
