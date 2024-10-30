import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DropdownInput extends StatefulWidget {
  DropdownInput({
    super.key,
    required this.options,
    required this.controller,
    required this.onChanged,
    required this.onEnter,
  }) {
    if (options.isEmpty) {
      throw ArgumentError("options cannot be empty");
    }

    for (var i = 0; i < options.length; i++) {
      entries.add(DropdownMenuItem(
        value: options[i],
        child: Text(
          options[i],
          style: TextStyle(color: colors[i % colors.length]),
        ),
      ));
    }
  }

  TextEditingController controller;
  FocusNode focusNode = FocusNode();
  final List<String> options;
  final List<DropdownMenuItem<String>> entries = [];
  final ValueChanged<String> onChanged;
  final VoidCallback onEnter;

  static const List<Color> colors = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
  ];

  @override
  State<DropdownInput> createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  late String value;

  @override
  void initState() {
    super.initState();
    value = widget.options.first;
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            DropdownButton(
              padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
              focusColor: Colors.transparent,
              underline: const SizedBox(),
              items: widget.entries,
              value: value,
              // Use the state variable
              onChanged: (String? newValue) {
                setState(() {
                  value = newValue!; // Update the state variable
                  widget.onChanged(newValue);
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: VerticalDivider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            Expanded(
              child: KeyboardListener(
                focusNode: widget.focusNode,
                onKeyEvent: (event) {
                  if (event is KeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.enter) {
                      widget.onEnter();
                    }
                  }
                },
                child: TextFormField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
