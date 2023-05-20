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
    const textStyle = TextStyle(color: Colors.white);
    return Container(
        width: size.width * 0.9,
        height: size.height * 0.3,
        decoration: boxContentDecoration,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is LoadingWeatherState) {
              return Center(child: _circleProgressIndicator());
            } else if (state is LoadedWeatherState) {
              final ConditionEntity condition =
                  ConditionUtil.getCondition(code: state.weatherEntity.current.condition.code);
              return Column(
                children: [
                  Row(
                    children: [
                      SizedBox(child: Image.asset('assets/weather/day/${condition.iconCode}.png')),
                      Text(condition.text, style: textStyle),
                    ],
                  ),
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
