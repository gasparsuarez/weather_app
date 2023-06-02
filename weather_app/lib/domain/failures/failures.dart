import 'package:dio/dio.dart';

class DioErrorException implements Exception {
  String fromDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return 'Respuesta de API cancelada.';
      case DioErrorType.badResponse:
        return 'Los datos ingresados no son correctos intente nuevamente.';
      case DioErrorType.badCertificate:
        return 'Bad certificate.';
      case DioErrorType.connectionError:
        return 'Error en la conexión.';
      case DioErrorType.connectionTimeout:
        return 'Connection timeout with Api';
      case DioErrorType.receiveTimeout:
        return 'Receive timeout in connection with Api.';
      case DioErrorType.sendTimeout:
        return 'Send timeout in connection with Api';
      case DioErrorType.unknown:
        return 'Error desconocido.';
    }
  }
}
