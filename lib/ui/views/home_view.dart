import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/providers/weather_notifier.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/ui/design_system/app_color.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14)),
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
                              onPressed: () => _clear(),
                            ),
                          ),
                        ),
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
              Builder(builder: (_) {
                final state = ref.watch(weatherNotifierProvider);
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (state is WeatherLoading)
                      ? const LoadingView()
                      : (state is WeatherLoaded)
                          ? ResultsView(weather: state.weather)
                          : const HomeBackground(),
                );
              }),
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
