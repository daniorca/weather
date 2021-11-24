import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/providers/weather_notifier.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/ui/design_system/app_text.dart';
import 'package:weather_app/ui/misc/helpers.dart';
import 'package:weather_app/ui/views/error_view.dart';
import 'package:weather_app/ui/widgets/home_background.dart';
import 'package:weather_app/ui/views/loading_view.dart';
import 'package:weather_app/ui/views/results_view.dart';
import 'package:weather_app/ui/widgets/app_icon_button.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: gradientDecoration,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        style: AppText.body15r('').style,
                        cursorColor: Colors.white,
                        controller: searchController,
                        decoration:
                            inputDecoration('Enter city name', () => _clear()),
                      ),
                    ),
                    const SizedBox(width: 15),
                    AppIconButton(
                      icon: Icons.search_outlined,
                      onPressed: () async => _getWeather(searchController.text),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Builder(builder: (_) {
                  final state = ref.watch(weatherNotifierProvider);
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: (state is WeatherLoading)
                        ? const LoadingView()
                        : (state is WeatherLoaded)
                            ? ResultsView(weather: state.weather)
                            : (state is WeatherError)
                                ? ErrorView(errorMessage: state.message)
                                : const HomeBackground(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getWeather(String cityName) async {
    await ref.read(weatherNotifierProvider.notifier).getWeather(cityName);
  }

  void _clear() {
    searchController.clear();
    ref.read(weatherNotifierProvider.notifier).weatherInitial();
  }
}
