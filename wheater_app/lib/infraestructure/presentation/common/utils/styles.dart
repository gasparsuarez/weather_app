import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';

final boxContentDecoration =
    BoxDecoration(borderRadius: BorderRadius.circular(20), color: gThirdColor);

const appBarContentDecoration = BoxDecoration(
    gradient: LinearGradient(
        colors: [gFirstColor, gSecondColor, gThirdColor],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft),
    borderRadius:
        BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)));

const gradientStyle = BoxDecoration(
    gradient: LinearGradient(
        colors: [gFirstColor, gSecondColor, gThirdColor],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft));

final bodyStyle = TextStyle(color: Colors.blueGrey.shade200, fontWeight: FontWeight.bold);
