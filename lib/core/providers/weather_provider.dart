import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/core/services/injection_container.dart';
import 'package:weather_app/core/services/weather_api_client.dart';

class WeatherProvider extends ChangeNotifier {

  WeatherApiClient weatherApiClient = getIt.get<WeatherApiClient>();

  Weather? weather;
  bool isLoading = false;
  set loading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getWeather(String city) async {
    try {
      loading = true;
      weather = await weatherApiClient.getWeather(city);
      loading = false;
    } on WeatherApiException catch (e) {
      print(e.message);
    } on SocketException catch (_) {
      print("Couldn't fetch data. Make sure you are connected to internet.");
    } catch (e) {
      print(e.toString());
    }
    
    
    //return weather;
  }
  
}