import 'package:multiple_result/multiple_result.dart';
import 'package:weather_app/domain/entities/forecast_entity.dart';
import 'package:weather_app/domain/failures/data_exception.dart';

import '../entities/search_location.dart';

abstract class IWeatherRepository {
  Future<Result<ForecastEntity, ErrorDataException>> getCurrentForecast(String name);
  Future<List<SearchLocation>> searchLocation(String location);
}
