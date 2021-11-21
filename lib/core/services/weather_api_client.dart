import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/models/weather.dart';

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com/api';

  Future<int> getLocationId(String city) async {

    final locationUrl = Uri.parse('$baseUrl/location/search/?query=$city');
    final response = await http.get(locationUrl);

    if (response.statusCode != 200) {
      throw WeatherApiException('Error getting locationId for city: $city');
    }

    final locationJson = jsonDecode(response.body) as List;
    if (locationJson.isEmpty) {
      throw WeatherApiException('No location found for city: $city');
    }
    
    return locationJson.first['woeid'] as int;
  }

  Future<Weather> fetchWeather(int locationId) async {
    
    final weatherUrl = Uri.parse('$baseUrl/location/$locationId');
    final response = await http.get(weatherUrl);

    if (response.statusCode != 200) {
      throw WeatherApiException('Error getting weather for location: $locationId');
    }
    final weatherJson = jsonDecode(response.body);
    final consolidatedWeather = weatherJson['consolidated_weather'] as List;
    if (consolidatedWeather.isEmpty) {
      throw WeatherApiException('Weather data is not available for location: $locationId');
    }
    return Weather.fromJson(weatherJson);
  }

  Future<Weather> getWeather(String city) async {
    final int locationId = await getLocationId(city);
    return fetchWeather(locationId);
  }
}

class WeatherApiException implements Exception {
  const WeatherApiException(this.message);
  final String message;
}