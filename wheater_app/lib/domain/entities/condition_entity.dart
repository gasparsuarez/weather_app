class ConditionEntity {
  final String text;
  final int iconCode;
  final bool isDay;

  ConditionEntity({this.isDay = false, required this.text, required this.iconCode});
}
