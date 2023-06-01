import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/blocs/blocs.dart';
import '../widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        const SliverAppBar(
            pinned: true,
            toolbarHeight: 90,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppBar(
                  title: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _RefreshButton(),
                      SizedBox(),
                      Text('Weather App', style: TextStyle(color: Colors.white, fontSize: 25)),
                      SizedBox(width: 2),
                      _ChangeTempType(),
                    ],
                  ),
                ),
              ])),
            )),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return const Column(
              children: [
                LocationInfoWidget(),
                SizedBox(height: 5),
                CurrentWeather(),
                SizedBox(height: 5),
                WeatherActuallyInfo(),
                SizedBox(height: 5),
                ForecastInfo(),
              ],
            );
          }, childCount: 1),
        )
      ],
    );
  }
}

class _ChangeTempType extends StatelessWidget {
  const _ChangeTempType();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureBloc, TemperatureState>(
      builder: (context, state) {
        return IconButton.filled(
          onPressed: () {
            context.read<TemperatureBloc>().add(ChangeTempEvent(isF: !state.isF));
          },
          icon: Text(
            state.isF ? '°F' : '°C',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        );
      },
    );
  }
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return IconButton.filled(
          onPressed: () {
            if (state is LoadedWeatherState) {
              context.read<WeatherBloc>().add(LoadWeatherEvent(
                  locationName:
                      '${state.forecastEntity.location.lat} ${state.forecastEntity.location.lon}'));
            }
          },
          icon: const Icon(Icons.refresh_rounded),
          color: Colors.white,
        );
      },
    );
  }
}
