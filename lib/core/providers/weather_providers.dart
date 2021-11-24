import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/core/providers/day_weather_notifier.dart';
import 'package:weather_app/core/providers/temp_notifier.dart';
import 'package:weather_app/core/providers/weather_notifier.dart';
import 'package:weather_app/core/services/local_cache.dart';
import 'package:weather_app/core/services/weather_api_client.dart';

final weatherApiClientProvider =
    Provider<WeatherApiClient>((_) => WeatherApiClient());

final dayWeatherNotifierProvider =
    StateNotifierProvider<DayWeatherNotifier, WeatherOfDay?>(
        (_) => DayWeatherNotifier());

final weatherNotifierProvider =
    StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(ref.read(weatherApiClientProvider), ref.read),
);

final sharedPreferences =
    FutureProvider<SharedPreferences>((_) async => SharedPreferences.getInstance());

final localCache = Provider<LocalCache>(
    (ref) => LocalCache(ref.watch(sharedPreferences).value!));

final tempNotifierProvider = StateNotifierProvider<TemperatureNotifier, bool>(
  (ref) => TemperatureNotifier(ref.read(localCache).isCelsius),
);
