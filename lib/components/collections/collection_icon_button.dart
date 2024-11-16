import 'package:flutter/material.dart';

class CollectionIconButton extends StatelessWidget {
  CollectionIconButton(
      {super.key, required this.onPressed, required this.icon});

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
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
