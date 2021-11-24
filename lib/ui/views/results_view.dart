import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/ui/design_system/app_color.dart';
import 'package:weather_app/ui/design_system/app_text.dart';
import 'package:weather_app/ui/widgets/selected_forecast.dart';
import 'package:weather_app/ui/widgets/weather_day_list.dart';

class ResultsView extends ConsumerWidget {
  final Weather weather;
  const ResultsView({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Center(
        child: RefreshIndicator(
      color: Colors.white,
      backgroundColor: AppColor.primaryLight,
      child: orientation == Orientation.portrait
          ? ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _cityName,
                          const SizedBox(height: 15),
                          SelectedForecast(weather.time),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child:
                          WeatherOfDayList(weatherOfDay: weather.weatherOfDay),
                    ),
                  ],
                )
              ],
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 55, 28, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              SelectedForecast(weather.time),
                              Positioned(
                                top: -60,
                                right: 0,
                                child: _cityName,
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.12),
                        ],
                      ),
                      SizedBox(width: 40),
                      WeatherOfDayList(weatherOfDay: weather.weatherOfDay),
                    ],
                  ),
                ),
              ],
            ),
      onRefresh: () async => await ref
          .read(weatherNotifierProvider.notifier)
          .getWeather(weather.cityName),
    ));
  }

  Widget get _cityName => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AppText.body24d(weather.cityName.toUpperCase()),
            AppText.body14r(weather.country)
          ],
        ),
      );
}
