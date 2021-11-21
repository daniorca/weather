import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/providers/weather_provider.dart';
import 'package:weather_app/ui/views/home_view.dart';
import 'package:weather_app/core/services/injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ChangeNotifierProvider(
        create: (context) => WeatherProvider(),
        child: HomeView(),
      ),
    );
  }
}
