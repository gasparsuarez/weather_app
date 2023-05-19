import 'package:dio/dio.dart';
import 'package:wheater_app/domain/entities/weather_entity.dart';

import '../presentation/common/config/constants/enviroments.dart';
import '../../domain/repositories/weather_repository.dart';

class WeatherRepository extends IWeatherRepository {
  final _key = Enviroments.wheaterKey;
  final dio = Dio();
  @override
  Future<WeatherEntity> getCurrentWeather(String name) async {
    final response = await dio.get('https://api.weatherapi.com/v1/current.json?key=$_key&q=$name',
        queryParameters: {'lang': 'es'});
    if (response.statusCode != 200) throw Exception('Not found');
    final weather = WeatherEntity.fromJson(response.data);
    return weather;
  }
}
