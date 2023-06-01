import 'package:flutter/material.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  final Widget title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: appBarContentDecoration,
      child: SafeArea(
        bottom: false,
        child: title,
      ),
    );
  }
}
