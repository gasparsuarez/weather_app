import 'package:wheater_app/domain/entities/condition_entity.dart';
import 'package:wheater_app/infraestructure/presentation/common/utils/conditions.dart';

class ConditionUtil {
  static getCondition({required int code, required bool isDay}) {
    final List<Map<String, dynamic>> conditions = WeatherConditions.weatherConditions;
    late ConditionEntity condition;
    for (var i = 0; i < conditions.length; i++) {
      if (conditions[i].containsValue(code)) {
        condition = ConditionEntity(
            text: conditions[i]['day'], iconCode: conditions[i]['icon'], isDay: isDay);
      }
    }
    return condition;
  }
}
