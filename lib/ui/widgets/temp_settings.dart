import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/ui/design_system/app_color.dart';
import 'package:weather_app/ui/design_system/app_text.dart';
import 'package:weather_app/ui/misc/helpers.dart';

class TemperatureSettings extends ConsumerStatefulWidget {
  TemperatureSettings({Key? key}) : super(key: key);

  @override
  _TemperatureSettingsState createState() => _TemperatureSettingsState();
}

class _TemperatureSettingsState extends ConsumerState<TemperatureSettings> {
  bool? _isCelsius;

  @override
  void initState() {
    _isCelsius = ref.read(localCache).isCelsius;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppText.body18r('Celsius'),
                Radio<bool>(
                  groupValue: _isCelsius!,
                  value: true,
                  onChanged: (value) => setState(() => _isCelsius = value),
                  fillColor: MaterialStateProperty.all(Colors.white),
                ),
                verticalSeparator,
                AppText.body18r('Fahrenheit'),
                Radio<bool>(
                  groupValue: _isCelsius!,
                  value: false,
                  onChanged: (value) => setState(() => _isCelsius = value),
                  fillColor: MaterialStateProperty.all(Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, _) => TextButton(
              onPressed: () {
                ref
                    .read(tempNotifierProvider.notifier)
                    .setUnitOfTemperature(_isCelsius!);
                ref.read(localCache).isCelsius = _isCelsius!;
                Navigator.of(context).pop();
              },
              child: AppText.body15r('Save Settings', color: Colors.white),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                backgroundColor: AppColor.lightWhiteMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}
