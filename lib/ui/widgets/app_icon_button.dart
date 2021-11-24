import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  const AppIconButton({Key? key, required this.icon, required this.onPressed, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        icon: Icon(
          icon,
          color: color,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
