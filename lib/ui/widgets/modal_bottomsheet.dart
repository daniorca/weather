import 'package:flutter/material.dart';
import 'package:weather_app/ui/design_system/app_text.dart';
import 'package:weather_app/ui/misc/helpers.dart';
import 'package:weather_app/ui/widgets/app_icon_button.dart';

class ModalBottomSheet extends StatelessWidget {
  ModalBottomSheet({
    this.title,
    this.body,
    Key? key,
  }) : super(key: key);

  final String? title;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    double inset = mq.viewInsets.bottom + mq.padding.bottom;

    return Container(
      decoration: gradientDecoration,
      child: Padding(
        padding: EdgeInsets.only(bottom: inset),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 20),
                AppText.body24r(title!),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: AppIconButton(
                    icon: Icons.close,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            Divider(),
            body!,
          ],
        ),
      ),
    );
  }
}
