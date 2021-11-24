import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/ui/misc/helpers.dart';
import 'package:weather_app/ui/views/home_view.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(sharedPreferences);

    return AsyncValueWidget(
      value: asyncValue,
      data: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomeView(),
      ),
    );
  }
}
