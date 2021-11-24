import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemperatureNotifier extends StateNotifier<bool> {
  TemperatureNotifier(bool isCelsius) : super(isCelsius);

  void setUnitOfTemperature(bool isCelsius) {
    state = isCelsius;
  }
}
