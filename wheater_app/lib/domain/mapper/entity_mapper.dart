import 'package:wheater_app/domain/entities/forecast_entity.dart';
import 'package:wheater_app/domain/entities/info_entity.dart';

class EntityMapper {
  static InfoEntity modelToEntity(ForecastEntity forecastEntity) {
    return InfoEntity(
        location: forecastEntity.location.name,
        country: forecastEntity.location.country,
        region: forecastEntity.location.region,
        tempC: forecastEntity.current.tempC);
  }
}
