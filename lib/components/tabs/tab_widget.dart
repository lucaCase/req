import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class TabWidget extends StatelessWidget {
  TabWidget({super.key, required this.text, required this.isActive});

  String text;
  bool isActive;

  @override
  Widget build(BuildContext context) {
    return isActive
        ? Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          )
        : GlowText(
            text,
            style: const TextStyle(
                fontSize: 20, color: Colors.red, fontWeight: FontWeight.w500),
          );
  }
}
