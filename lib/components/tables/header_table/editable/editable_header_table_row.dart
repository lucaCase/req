import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:req/styles/table_row_styles.dart';

import '../../../../utils/networking/http/http_headers.dart';

class EditableHeaderTableRow extends StatefulWidget {
  EditableHeaderTableRow(
      {super.key,
      required this.keyController,
      required this.valueController,
      required this.onEnable,
      required this.onDelete,
      this.isEnabled = true,
      required this.index});

  TextEditingController keyController;

  TextEditingController valueController;

  final Function onEnable;
  final VoidCallback onDelete;
  bool isEnabled;
  int index;

  @override
  State<EditableHeaderTableRow> createState() => _EditableHeaderTableRowState();
}

class _EditableHeaderTableRowState extends State<EditableHeaderTableRow> {
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
                        onPressed: () {},
                        icon: const Icon(Icons.drag_indicator))),
              ),
            ),
            Expanded(
              child: DropDownSearchField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: widget.keyController,
                  style: textStyle,
                  decoration: inputDecoration("Key"),
                ),
                suggestionsCallback: (pattern) {
                  return headers
                      .where((element) =>
                          element.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();
                },
                onSuggestionSelected: (suggestion) {
                  widget.keyController.text = suggestion;
                },
                itemBuilder: (BuildContext context, String itemData) {
                  return ListTile(
                    title: Text(itemData),
                  );
                },
                displayAllSuggestionWhenTap: true,
                layoutArchitecture: (items, scrollController) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: items.toList(),
                    ),
                  );
                },
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
                  onPressed: () {
                    setState(() {
                      widget.onEnable();
                      widget.isEnabled = !widget.isEnabled;
                    });
                  },
                  icon: Icon(widget.isEnabled
                      ? Icons.check_circle_outline
                      : Icons.radio_button_unchecked),
                  color: Colors.green,
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
        ));
  }
}
