import 'package:flutter/material.dart';
import '../config/theme/app_theme.dart';

final boxContentDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: const LinearGradient(
        colors: [gFirstColor, gSecondColor, gThirdColor],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft));
