import 'package:flutter/material.dart';
import 'package:wheater_app/infraestructure/presentation/common/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

// TODO: Continuar con el current weather.

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomAppbar(),
        SizedBox(height: 20),
        SearchField(),
        SizedBox(height: 10),
        LocationInfoWidget(),
        SizedBox(height: 20),
        CurrentWeather(),
      ],
    );
  }
}
