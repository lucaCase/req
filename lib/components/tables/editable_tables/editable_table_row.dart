import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:req/styles/table_row_styles.dart';

class EditableTableRow extends StatefulWidget {
  EditableTableRow(
      {super.key,
      required this.onDelete,
      required this.keyController,
      required this.valueController,
      this.isEnabled = true,
      required this.onEnable,
      required this.index});

  TextEditingController keyController;

  TextEditingController valueController;

  final Function onEnable;
  final VoidCallback onDelete;
  bool isEnabled;
  int index;

  @override
  State<EditableTableRow> createState() => _EditableTableRowState();
}

class _EditableTableRowState extends State<EditableTableRow> {
  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          bool altIsPressed = HardwareKeyboard.instance.isAltPressed;
          bool isMinusOrDelPressed =
              event.logicalKey == LogicalKeyboardKey.delete ||
                  event.logicalKey == LogicalKeyboardKey.minus;
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
              child: ReorderableDragStartListener(
                  index: widget.index,
                  child: IconButton(
                    icon: const Icon(Icons.drag_indicator),
                    onPressed: () {},
                  )),
            ),
          ),
          Expanded(
            child: TextField(
              style: textStyle,
              decoration: inputDecoration("Key"),
              controller: widget.keyController,
            ),
          ),
          Expanded(
            child: TextField(
              style: textStyle,
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
                    widget.onEnable();
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
