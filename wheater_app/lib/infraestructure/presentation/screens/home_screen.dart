import 'package:flutter/material.dart';
import 'package:wheater_app/infraestructure/presentation/common/widgets/custom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  final Widget childView;
  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
