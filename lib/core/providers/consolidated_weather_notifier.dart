import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/models/weather.dart';

abstract class ConsolidatedWeatherState {
  const ConsolidatedWeatherState();
}

class ConsolidatedWeatherSelected extends ConsolidatedWeatherState {
  final ConsolidatedWeather consolidatedWeather;
  const ConsolidatedWeatherSelected(this.consolidatedWeather);
}

class ConsolidatedWeatherInitial extends ConsolidatedWeatherState {
  const ConsolidatedWeatherInitial();
}

class ConsolidatedWeatherNotifier extends StateNotifier<ConsolidatedWeatherState> {
  ConsolidatedWeatherNotifier() : super(ConsolidatedWeatherInitial());

  void setConsolidatedWeather(ConsolidatedWeather consolidatedWeather) {
    state = ConsolidatedWeatherSelected(consolidatedWeather);
  }
}