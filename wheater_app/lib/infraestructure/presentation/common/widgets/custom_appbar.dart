import 'package:flutter/material.dart';
import 'package:wheater_app/config/theme/app_theme.dart';
import 'package:wheater_app/infraestructure/presentation/common/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const boxDecoration = BoxDecoration(
        gradient: LinearGradient(
            colors: [gFirstColor, gSecondColor, gThirdColor],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft),
        borderRadius:
            BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)));

    return Container(
      width: double.infinity,
      height: 200,
      decoration: boxDecoration,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Weather App',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )
              ],
            ),
            const Spacer(),
            const SearchField(),
          ],
        ),
      ),
    );
  }
}
