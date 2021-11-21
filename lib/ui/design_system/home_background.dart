import 'package:flutter/material.dart';
import 'package:weather_app/ui/design_system/app_asset.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        const SizedBox(height: 80),
        Text(
          'Welcome',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Type the name of a city to get the weather',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6)),
        ),
        const SizedBox(height: 80),
        AppAsset.image(AppAsset.backgroundImage, width: size.width * .75),
      ],
    );
  }
}