import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/infraestructure/presentation/app.dart';
import 'package:weather_app/infraestructure/dependency_injection/bloc_register.dart';
import 'package:weather_app/infraestructure/dependency_injection/repository_register.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  BlocRegister();
  RepositoryRegister();
  runApp(const WeatherApp());
}
