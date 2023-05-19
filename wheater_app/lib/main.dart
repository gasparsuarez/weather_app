import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wheater_app/app.dart';
import 'package:wheater_app/infraestructure/dependency_injection/bloc_register.dart';
import 'package:wheater_app/infraestructure/dependency_injection/repository_register.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  BlocRegister();
  RepositoryRegister();
  runApp(const WeatherApp());
}
