import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/models/weather.dart';

class DayWeatherNotifier extends StateNotifier<WeatherOfDay?> {
  DayWeatherNotifier() : super(null);

  void weatherSelected(WeatherOfDay weatherOfDay) {
    state = weatherOfDay;
  }
}