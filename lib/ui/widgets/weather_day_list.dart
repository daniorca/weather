import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/models/weather.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/ui/design_system/app_asset.dart';
import 'package:weather_app/ui/design_system/app_color.dart';
import 'package:weather_app/ui/design_system/app_text.dart';
import 'package:weather_app/ui/misc/helpers.dart';
import 'package:weather_app/ui/widgets/min_max_temp.dart';

class WeatherOfDayList extends ConsumerStatefulWidget {
  const WeatherOfDayList({
    Key? key,
    required this.weatherOfDay,
  }) : super(key: key);

  final List<WeatherOfDay> weatherOfDay;

  @override
  _WeatherOfDayListState createState() => _WeatherOfDayListState();
}

class _WeatherOfDayListState extends ConsumerState<WeatherOfDayList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final double imageSize = orientation == Orientation.portrait ? 70 : 50;
    return Container(
      width: orientation == Orientation.portrait
          ? double.infinity
          : size.width * .40,
      height: orientation == Orientation.portrait ? 150 : 280,
      child: orientation == Orientation.portrait
          ? ListView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              children: _weatherOfDayList(imageSize, orientation),
            )
          : GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: _weatherOfDayList(imageSize, orientation)),
    );
  }

  List<Widget> _weatherOfDayList(double imageSize, Orientation orientation) => [
        ...widget.weatherOfDay.map(
          (e) => GestureDetector(
            onTap: () => _setSelected(e),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 150,
                        width: 120,
                        decoration: cardBoxDecoration(
                            color: e.isSelected
                                ? AppColor.lightWhiteStrong
                                : Colors.white12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppText.body18r(
                                '${DateFormat.E().format(e.applicableDate)}'),
                            const SizedBox(height: 14),
                            MinMaxTemperature(
                              minTemp: e.minTemp,
                              maxTemp: e.maxTemp,
                            ),
                            const SizedBox(height: 6),
                            AppText.caption12r(
                                '${DateFormat.yMd().format(e.applicableDate)}',
                                color: AppColor.lightWhite),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Positioned(
                        top: (e.isSelected &&
                                orientation == Orientation.portrait)
                            ? -30
                            : orientation == Orientation.portrait
                                ? -20
                                : -10,
                        left: orientation == Orientation.portrait ? 24 : 30,
                        child: AppAsset.image('${e.weatherStateAbbr}.png',
                            width: imageSize, height: imageSize),
                      )
                    ],
                  ),
                  const SizedBox(width: 18),
                ],
              ),
            ),
          ),
        )
      ];

  void _setSelected(WeatherOfDay weather) {
    ref.read(dayWeatherNotifierProvider.notifier).weatherSelected(weather);
    setState(() => widget.weatherOfDay.forEach(
        (e) => e != weather ? e.isSelected = false : e.isSelected = true));
  }
}
