import 'package:flutter/material.dart';

class DropdownInput extends StatefulWidget {

  DropdownInput({super.key, required this.options}) {
    if (options.isEmpty) {
      throw ArgumentError("options cannot be empty");
    }
    value = options.first;

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

  final List<Color> colors = [
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

  List<DropdownMenuItem<String>> entries = [];

  ValueChanged<String> onChanged = (val) => val;

  List<String> options;
  String value = "";

  @override
  State<DropdownInput> createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {


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
              value: widget.value,
              onChanged: (String? value) {
                setState(() {
                  widget.value = value!;
                  widget.onChanged(widget.value);
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
              child: TextFormField(
                decoration: const InputDecoration(
                  
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
