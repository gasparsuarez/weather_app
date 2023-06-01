import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/styles.dart';

import '../../../../application/blocs/blocs.dart';

class LocationInfoWidget extends StatelessWidget {
  const LocationInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: size.width * 0.95,
        height: 70,
        decoration: boxContentDecoration,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is LoadedWeatherState) {
              final forecastLocation = state.forecastEntity.location;
              return FadeIn(
                duration: const Duration(seconds: 2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LocationInfo(
                        name: forecastLocation.name,
                        region: forecastLocation.region,
                        country: forecastLocation.country,
                      ),
                    ],
                  ),
                ),
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

class _LocationInfo extends StatelessWidget {
  final String name;
  final String region;
  final String country;

  const _LocationInfo({
    required this.name,
    required this.region,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: name.length > 20 ? 200 : null,
          child: Text(
            name,
            style: const TextStyle(color: Colors.amber, fontSize: 20),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            Text(
              region,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            Text(region.isEmpty ? '' : ', ', style: textStyle),
            Text(country, style: textStyle, textAlign: TextAlign.center),
          ],
        ),
      ],
    );
  }
}
