import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroments {
  static String wheaterKey = dotenv.env['WHEATER_KEY'] ?? 'Key is empty';
}
