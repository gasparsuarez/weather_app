import 'package:flutter/material.dart';

const gFirstColor = Color(0xff0F2027);
const gSecondColor = Color(0xff203A43);
const gThirdColor = Color(0xff2C5364);

class AppTheme {
  getTheme() => ThemeData(
        useMaterial3: false,
        colorSchemeSeed: Colors.grey,
      );
}
