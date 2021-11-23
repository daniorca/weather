import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/core/services/weather_api_client.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  const WeatherLoaded(this.weather);
}
class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);
}

class WeatherNotifier extends StateNotifier<WeatherState> {
  final WeatherApiClient _weatherApiClient;
  final Reader _reader;

  WeatherNotifier(this._weatherApiClient, this._reader) : super(const WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      state = const WeatherLoading();
      final weather = await _weatherApiClient.getWeather(cityName);
      state = WeatherLoaded(weather);
      weather.weatherOfDay.first.isSelected = true;
      _reader(dayWeatherNotifierProvider.notifier).weatherSelected(weather.weatherOfDay.first);
    } on WeatherApiException catch (e) {
      _weatherError(e.message);
    } on SocketException catch (_) {
      _weatherError(
          "Couldn't fetch data. Make sure you are connected to internet.");
    } catch (e) {
      _weatherError(e.toString());
    }
  }

  void weatherInitial() {
    state = const WeatherInitial();
  }

  void _weatherError(String message) {
    state = WeatherError(message);
  }
}
