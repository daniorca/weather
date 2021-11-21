import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/providers/weather_provider.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          '${weatherProvider.weather?.cityName}',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          '${weatherProvider.weather?.country}',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          '${weatherProvider.weather?.consolidatedWeather[0].weatherStateName}',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}