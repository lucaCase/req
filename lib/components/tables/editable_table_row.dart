import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditableTableRow extends StatefulWidget {
  EditableTableRow({super.key, required this.onDelete, required this.keyController, required this.valueController});

  TextEditingController keyController = TextEditingController();

  TextEditingController valueController = TextEditingController();

  static const iBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12, width: 0),
    borderRadius: BorderRadius.zero,
  );
  static const textStyle = TextStyle(fontSize: 14);

  final VoidCallback onDelete;


  bool isEnabled = true;

  @override
  State<EditableTableRow> createState() => _EditableTableRowState();
}

class _EditableTableRowState extends State<EditableTableRow> {

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
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          bool altIsPressed = HardwareKeyboard.instance.isAltPressed;
          bool isMinusOrDelPressed = event.logicalKey == LogicalKeyboardKey.delete || event.logicalKey == LogicalKeyboardKey.minus;
          if (altIsPressed && isMinusOrDelPressed) {
            setState(() {
              widget.onDelete();
            });
          }
        }
      },
      child: Row(
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
              controller: widget.keyController,
            ),
          ),
          Expanded(
            child: TextField(
              style: EditableTableRow.textStyle,
              decoration: inputDecoration("Value"),
              controller: widget.valueController,
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
                  widget.isEnabled
                      ? Icons.check_circle_outline
                      : Icons.radio_button_unchecked,
                  color: Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    widget.isEnabled = !widget.isEnabled;
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
                  setState(() {
                    widget.onDelete();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
