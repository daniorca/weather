import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/models/weather.dart';
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

  WeatherNotifier(this._weatherApiClient) : super(const WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      state = const WeatherLoading();
      final weather = await _weatherApiClient.getWeather(cityName);
      state = WeatherLoaded(weather);
    } on WeatherApiException catch (e) {
      weatherError(e.message);
    } on SocketException catch (_) {
      weatherError("Couldn't fetch data. Make sure you are connected to internet.");
    } catch (e) {
      weatherError(e.toString());
    }
  }

  void weatherError(String message) {
    state = WeatherError(message);
  }

  void weatherInitial() {
    state = const WeatherInitial();
  }
}
