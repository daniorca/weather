class Weather {
  const Weather({
    required this.consolidatedWeather,
    required this.time,
    required this.sunRise,
    required this.sunSet,
    required this.cityName,
    required this.country,
  });

  final List<ConsolidatedWeather> consolidatedWeather;
  final DateTime time;
  final DateTime sunRise;
  final DateTime sunSet;
  final String cityName;
  final String country;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        consolidatedWeather: List<ConsolidatedWeather>.from(
            json["consolidated_weather"]
                .map((x) => ConsolidatedWeather.fromJson(x))),
        time: DateTime.parse(json["time"]),
        sunRise: DateTime.parse(json["sun_rise"]),
        sunSet: DateTime.parse(json["sun_set"]),
        cityName: json["title"],
        country: json['parent']['title'],
      );
}

class ConsolidatedWeather {
  const ConsolidatedWeather({
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.currentTemp,
    required this.windSpeed,
    required this.windDirection,
    required this.airPressure,
    required this.humidity,
  });

  final String weatherStateName;
  final String weatherStateAbbr;
  final DateTime applicableDate;
  final double minTemp;
  final double maxTemp;
  final double currentTemp;
  final int humidity;
  final double windSpeed;
  final double windDirection;
  final double airPressure;

  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
      ConsolidatedWeather(
        weatherStateName: json["weather_state_name"],
        weatherStateAbbr: json["weather_state_abbr"],
        applicableDate: DateTime.parse(json["applicable_date"]),
        minTemp: json["min_temp"].toDouble(),
        maxTemp: json["max_temp"].toDouble(),
        currentTemp: json["the_temp"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        windDirection: json["wind_direction"].toDouble(),
        airPressure: json["air_pressure"].toDouble(),
        humidity: json["humidity"],
      );
}
