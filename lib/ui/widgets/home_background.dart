import 'package:flutter/material.dart';
import 'package:weather_app/ui/design_system/app_asset.dart';
import 'package:weather_app/ui/design_system/app_color.dart';
import 'package:weather_app/ui/design_system/app_text.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      height: size.height * .8,
      child: Center(
        child: orientation == Orientation.portrait
            ? Column(
                children: <Widget>[
                  SizedBox(height: size.height * .1),
                  _welcomeWidget,
                  const SizedBox(height: 16),
                  _instructions,
                  const SizedBox(height: 80),
                  _backgroundImage(size.width * .75)
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: size.height * .1),
                      _welcomeWidget,
                      const SizedBox(width: 16),
                      _instructions,
                    ],
                  ),
                  _backgroundImage(size.width * .40)
                ],
              ),
      ),
    );
  }

  Widget get _welcomeWidget => AppText.title30d('Welcome');

  Widget get _instructions =>
      AppText.body14r('Type the name of a city to get the weather',
          color: AppColor.lightWhite);

  Widget _backgroundImage(double width) => AppAsset.image(
        AppAsset.backgroundImage,
        width: width,
      );
}
