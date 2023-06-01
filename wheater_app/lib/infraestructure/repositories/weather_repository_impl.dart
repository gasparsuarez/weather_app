import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:wheater_app/domain/entities/forecast_entity.dart';
import 'package:wheater_app/domain/entities/search_location.dart';
import 'package:wheater_app/domain/failures/failures.dart';

import '../../config/constants/enviroments.dart';
import '../../domain/failures/data_exception.dart';
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
  Future<Result<ForecastEntity, ErrorDataException>> getCurrentForecast(String name) async {
    try {
      final response = await dio.get('forecast.json', queryParameters: {'q': name, 'days': 14});
      final forecastEntity = ForecastEntity.fromJson(response.data);
      return Success(forecastEntity);
    } on DioError catch (e) {
      return Error(ErrorDataException(DioErrorException().fromDioError(e)));
    }
  }

  @override
  Future<List<SearchLocation>> searchLocation(String location) async {
    try {
      final response = await dio.get('search.json', queryParameters: {"q": location});
      if (response.statusCode != 200) return throw Exception('error data');
      final List<SearchLocation> locations =
          List.of(response.data).map((e) => SearchLocation.fromJson(e)).toList();
      return locations;
    } on DioError catch (e) {
      throw e.error.toString();
    }
  }
}
