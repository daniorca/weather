import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/core/providers/day_weather_notifier.dart';
import 'package:weather_app/core/providers/weather_notifier.dart';
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
