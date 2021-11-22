import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .65,
      child: Center(
        child: SpinKitRipple(
          color: Colors.white,
          size: 150.0,
        ),
      ),
    );
  }
}