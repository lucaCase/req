import 'package:flutter/material.dart';

class EditableTableRow extends StatefulWidget {
  EditableTableRow({super.key});

  static const iBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12, width: 0),
    borderRadius: BorderRadius.zero,
  );
  static const textStyle = TextStyle(fontSize: 14);

  @override
  State<EditableTableRow> createState() => _EditableTableRowState();
}

class _EditableTableRowState extends State<EditableTableRow> {
  TextEditingController keyController = TextEditingController();

  TextEditingController valueController = TextEditingController();

  bool isEnable = true;

  Map<String, String> getValues() {
    return {keyController.text: valueController.text};
  }

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black54),
      border: EditableTableRow.iBorder,
      focusedBorder: EditableTableRow.iBorder,
      enabledBorder: EditableTableRow.iBorder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 37,
          height: 37,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0),
            ),
            child: IconButton(
              icon: const Icon(Icons.drag_indicator),
              onPressed: () {},
            ),
          ),
        ),
        Expanded(
          child: TextField(
            style: EditableTableRow.textStyle,
            decoration: inputDecoration("Key"),
            controller: keyController,
          ),
        ),
        Expanded(
          child: TextField(
            style: EditableTableRow.textStyle,
            decoration: inputDecoration("Value"),
            controller: valueController,
          ),
        ),
        SizedBox(
          width: 37,
          height: 37,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0),
            ),
            child: IconButton(
              icon: Icon(
                isEnable
                    ? Icons.check_circle_outline
                    : Icons.radio_button_unchecked,
                color: Colors.green,
              ),
              onPressed: () {
                setState(() {
                  isEnable = !isEnable;
                });
              },
            ),
          ),
        ),
        SizedBox(
          width: 37,
          height: 37,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
              },
            ),
          ),
        ),
      ],
    );
  }
}
