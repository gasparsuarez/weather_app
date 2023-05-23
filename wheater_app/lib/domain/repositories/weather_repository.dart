import 'package:wheater_app/domain/entities/forecast_entity.dart';

abstract class IWeatherRepository {
  Future<ForecastEntity> getCurrentForecast(String name);
}
