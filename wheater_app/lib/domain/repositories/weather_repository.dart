import 'package:wheater_app/domain/entities/weather_entity.dart';

abstract class IWeatherRepository {
  Future<WeatherEntity> getCurrentWeather(String name);
}
