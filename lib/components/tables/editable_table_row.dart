import 'package:flutter/material.dart';

class EditableTableRow extends StatelessWidget {
  EditableTableRow({super.key});

  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  Map<String, String> getValues() {
    return {keyController.text: valueController.text};
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
                border: InputBorder.none
            ),
            controller: keyController,
          ),
        ),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none
            ),
            controller: valueController,
          ),
        ),
      ],
    );
  }
}
