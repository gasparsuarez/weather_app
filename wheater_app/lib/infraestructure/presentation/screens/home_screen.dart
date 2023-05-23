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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomAppBar(),
        SizedBox(height: 20),
        LocationInfoWidget(),
        SizedBox(height: 20),
        CurrentWeather(),
        SizedBox(height: 20),
      ],
    );
  }
}
