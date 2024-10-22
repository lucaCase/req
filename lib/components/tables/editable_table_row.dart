import 'package:flutter/material.dart';

class EditableTableRow extends StatelessWidget {
  EditableTableRow({super.key});

  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  static const iBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
    borderRadius: BorderRadius.zero
  );
  static const textStyle = TextStyle(fontSize: 14);

  Map<String, String> getValues() {
    return {keyController.text: valueController.text};
  }

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      border: iBorder,
      focusedBorder: iBorder,
      enabledBorder: iBorder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: textStyle,
            decoration: inputDecoration("Key"),
            controller: keyController,
          ),
        ),
        Expanded(
          child: TextField(
            style: textStyle,
            decoration: inputDecoration("Value"),
            controller: valueController,
          ),
        ),
      ],
    );
  }
}
