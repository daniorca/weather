import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/providers/weather_providers.dart';
import 'package:weather_app/ui/design_system/app_asset.dart';
import 'package:weather_app/ui/design_system/app_color.dart';
import 'package:weather_app/ui/design_system/app_text.dart';
import 'package:weather_app/ui/misc/helpers.dart';

class ErrorView extends StatelessWidget {
  final String errorMessage;
  const ErrorView({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      height: size.height * .8,
      child: orientation == Orientation.portrait
          ? Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.08),
                _backgroundImage(size.width),
                SizedBox(height: size.height * 0.05),
                _errorMessage(),
                SizedBox(height: size.height * 0.03),
                _retryButton
              ],
            )
          : Row(
              children: <Widget>[
                _backgroundImage(size.width * .4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _errorMessage(width: 300),
                    SizedBox(height: size.height * 0.03),
                    _retryButton,
                  ],
                )
              ],
            ),
    );
  }

  Widget _backgroundImage(double width) => AppAsset.image(
        AppAsset.error,
        width: width,
      );

  Widget _errorMessage({double width = double.infinity}) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 28),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: width,
        height: 100,
        decoration: cardBoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: AppText.body15r(
              errorMessage,
              maxLines: 2,
              textAlign: TextAlign.center,
            )),
          ],
        ),
      );

  Widget get _retryButton => Consumer(
        builder: (BuildContext context, WidgetRef ref, _) => TextButton(
          onPressed: () =>
              ref.read(weatherNotifierProvider.notifier).weatherInitial(),
          child: AppText.body18r('Retry', color: Colors.white),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            backgroundColor: AppColor.lightWhiteMedium,
          ),
        ),
      );
}
