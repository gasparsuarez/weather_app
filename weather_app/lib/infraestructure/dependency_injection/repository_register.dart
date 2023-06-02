import 'package:injector/injector.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/infraestructure/repositories/weather_repository_impl.dart';

class RepositoryRegister {
  final injector = Injector.appInstance;

  RepositoryRegister() {
    injector.registerDependency<IWeatherRepository>(() {
      return WeatherRepository();
    });
  }
}
