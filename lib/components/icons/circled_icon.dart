import 'package:flutter/material.dart';

class CircledIcon extends StatelessWidget {
  const CircledIcon({super.key, required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          icon,
          color: const Color(0xFF2B2D30),
          size: 16,
        ),
      ),
    );
  }
}
