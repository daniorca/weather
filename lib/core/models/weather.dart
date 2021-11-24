class Weather {
  const Weather({
    required this.weatherOfDay,
    required this.time,
    required this.cityName,
    required this.country,
  });

  final List<WeatherOfDay> weatherOfDay;
  final DateTime time;
  final String cityName;
  final String country;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        weatherOfDay: List<WeatherOfDay>.from(
            json["consolidated_weather"].map((x) => WeatherOfDay.fromJson(x))),
        time: DateTime.parse(json["time"]),
        cityName: json["title"],
        country: json['parent']['title'],
      );
}

class WeatherOfDay {
  WeatherOfDay({
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.currentTemp,
    required this.windSpeed,
    required this.airPressure,
    required this.humidity,
    this.isSelected = false,
  });

  final String weatherStateName;
  final String weatherStateAbbr;
  final DateTime applicableDate;
  final double minTemp;
  final double maxTemp;
  final double currentTemp;
  final int humidity;
  final double windSpeed;
  final double airPressure;
  bool isSelected;

  factory WeatherOfDay.fromJson(Map<String, dynamic> json) => WeatherOfDay(
        weatherStateName: json["weather_state_name"],
        weatherStateAbbr: json["weather_state_abbr"],
        applicableDate: DateTime.parse(json["applicable_date"]),
        minTemp: json["min_temp"].toDouble(),
        maxTemp: json["max_temp"].toDouble(),
        currentTemp: json["the_temp"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        airPressure: json["air_pressure"].toDouble(),
        humidity: json["humidity"],
      );
}
