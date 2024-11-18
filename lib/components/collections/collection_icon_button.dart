import 'package:flutter/material.dart';

class CollectionIconButton extends StatelessWidget {
  CollectionIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.tooltip});

  final VoidCallback onPressed;
  final IconData icon;
  String tooltip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: tooltip,
          onPressed: () => onPressed(),
          icon: Icon(icon),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ],
    );
  }
}
