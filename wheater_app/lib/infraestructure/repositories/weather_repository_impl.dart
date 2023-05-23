import 'package:dio/dio.dart';
import 'package:wheater_app/domain/entities/forecast_entity.dart';

import '../presentation/common/config/constants/enviroments.dart';
import '../../domain/repositories/weather_repository.dart';

class WeatherRepository extends IWeatherRepository {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.weatherapi.com/v1/',
      queryParameters: {
        'key': Enviroments.wheaterKey,
        'lang': 'es',
      },
    ),
  );
  @override
  Future<ForecastEntity> getCurrentForecast(String name) async {
    final response = await dio.get('forecast.json', queryParameters: {
      'q': name,
      'days': 5,
    });
    if (response.statusCode != 200) throw Exception('Error data');
    final forecastEntity = ForecastEntity.fromJson(response.data);
    print(response.data);
    return forecastEntity;
  }
}
