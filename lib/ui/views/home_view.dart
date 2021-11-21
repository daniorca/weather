import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/providers/weather_provider.dart';
import 'package:weather_app/ui/design_system/app_color.dart';
import 'package:weather_app/ui/design_system/home_background.dart';
import 'package:weather_app/ui/views/results_view.dart';
import 'package:weather_app/ui/widgets/app_icon_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: AppColor.bgGradient,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16)),
                        child: TextField(
                          cursorColor: Colors.white,
                          controller: searchController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(left: 10, top: 14),
                              border: InputBorder.none,
                              hintText: 'Enter city name',
                              suffixIcon: AppIconButton(
                                  icon: Icons.clear,
                                  onPressed: () => searchController.clear())),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    AppIconButton(
                      icon: Icons.search_outlined,
                      onPressed: () =>
                          Provider.of<WeatherProvider>(context, listen: false)
                              .getWeather(searchController.text),
                    ),
                  ],
                ),
              ),
              Consumer<WeatherProvider>(builder: (context, weatherProvider, _) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: weatherProvider.isLoading
                      ? Container(
                          height: size.height * .7,
                          child: const Center(
                            child: SpinKitRipple(
                              color: Colors.white,
                              size: 150.0,
                            ),
                          ))
                      : weatherProvider.weather != null
                          ? ResultsView()
                          : HomeBackground(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
