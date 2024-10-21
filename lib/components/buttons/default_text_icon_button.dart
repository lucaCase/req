import 'package:flutter/material.dart';

class DefaultTextIconButton extends StatelessWidget {
  const DefaultTextIconButton({super.key, required this.icon, required this.label, required this.onPressed});
  final Icon icon;
  final Text label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      icon: icon,
      label: label
    );
  }
}
