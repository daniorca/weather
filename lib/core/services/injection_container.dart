import 'package:get_it/get_it.dart';
import 'package:weather_app/core/services/weather_api_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {

  //api client
  getIt.registerLazySingleton<WeatherApiClient>(() => WeatherApiClient());

}
