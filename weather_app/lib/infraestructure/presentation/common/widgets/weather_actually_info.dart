import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/blocs/blocs.dart';
import '../utils/styles.dart';

class WeatherActuallyInfo extends StatelessWidget {
  const WeatherActuallyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TemperatureBox(),
        SizedBox(width: 10),
        _AstroBox(),
      ],
    );
  }
}

class _TemperatureBox extends StatelessWidget {
  const _TemperatureBox();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.46,
      height: 150,
      decoration: boxContentDecoration,
      child: Column(
        children: [
          const SizedBox(height: 5),
          const Text('Hoy', style: TextStyle(fontSize: 20, color: Colors.white)),
          const Divider(color: Colors.blueGrey),
          const SizedBox(height: 5),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is LoadedWeatherState) {
                final temp = state.forecastEntity.forecast.forecastday[0];
                return FadeIn(
                  duration: const Duration(seconds: 2),
                  child: _TemperatureData(
                      maxTempC: temp.day.maxtempC,
                      minTempC: temp.day.mintempC,
                      maxTempF: temp.day.maxtempF,
                      minTempF: temp.day.mintempF),
                );
              }
              return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white));
            },
          )
        ],
      ),
    );
  }
}

class _TemperatureData extends StatelessWidget {
  final double maxTempC;
  final double minTempC;
  final double maxTempF;
  final double minTempF;
  const _TemperatureData(
      {required this.maxTempC,
      required this.maxTempF,
      required this.minTempC,
      required this.minTempF});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white, fontSize: 20);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocBuilder<TemperatureBloc, TemperatureState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Row(children: [
                  const Text('Máx:', style: textStyle),
                  const SizedBox(width: 10),
                  Text(state.isF ? '$maxTempF° F' : '$maxTempC° C', style: bodyStyle),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  const Text('Mín:', style: textStyle),
                  const SizedBox(width: 10),
                  Text(state.isF ? '$minTempF° F' : '$minTempC° C', style: bodyStyle),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AstroBox extends StatelessWidget {
  const _AstroBox();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.46,
      height: 150,
      decoration: boxContentDecoration,
      child: SizedBox(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is LoadedWeatherState) {
              final astroData = state.forecastEntity.forecast.forecastday[0];
              final isDayData = state.forecastEntity.current;
              return FadeIn(
                duration: const Duration(seconds: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _AstroData(
                        isDay: isDayData.isDay,
                        sunset: astroData.astro.sunset,
                        sunrise: astroData.astro.sunrise,
                        moonset: astroData.astro.moonset,
                        moonrise: astroData.astro.moonrise)
                  ],
                ),
              );
            }
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white));
          },
        ),
      ),
    );
  }
}

class _AstroData extends StatelessWidget {
  final String sunset;
  final String moonset;
  final String moonrise;
  final String sunrise;
  final int isDay;

  const _AstroData(
      {required this.sunset,
      required this.sunrise,
      required this.isDay,
      required this.moonset,
      required this.moonrise});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 20, color: Colors.white);
    final bodyStyle = TextStyle(color: Colors.blueGrey.shade200, fontWeight: FontWeight.bold);
    return Column(
      children: [
        Text(isDay == 0 ? 'Puesta de luna' : 'Salida de Luna', style: titleStyle),
        Text(isDay == 0 ? moonset : moonrise, style: bodyStyle),
        const SizedBox(height: 20),
        Text(isDay == 0 ? 'Amanecer' : 'Atardecer', style: titleStyle),
        Text(isDay == 0 ? sunrise : sunset, style: bodyStyle),
      ],
    );
  }
}
