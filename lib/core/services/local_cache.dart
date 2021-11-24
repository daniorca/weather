import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  final SharedPreferences _preferences;

  LocalCache(this._preferences);

  bool get isCelsius => _preferences.getBool('isCelsius') ?? true;
  set isCelsius(bool value) => _preferences.setBool('isCelsius', value);
}
