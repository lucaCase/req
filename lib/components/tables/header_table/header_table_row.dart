import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:req/styles/table_row_styles.dart';

class HeaderTableRow extends StatefulWidget {
  HeaderTableRow(
      {super.key, required this.headerKey, required this.headerValue});

  final String headerKey;
  final String headerValue;

  @override
  State<HeaderTableRow> createState() => _HeaderTableRowState();
}

class _HeaderTableRowState extends State<HeaderTableRow> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          readOnly: true,
          controller: TextEditingController()..text = widget.headerKey,
          style: textStyle,
          decoration: inputDecoration(""),
        )),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          decoration: const BoxDecoration(
            border: Border(
              left: borderSide,
              bottom: borderSide,
              top: borderSide,
            ),
          ),
          child: TextField(
              //THIS ONE HERE
              readOnly: true,
              controller: TextEditingController()..text = widget.headerValue,
              style: textStyle,
              decoration: const InputDecoration(
                isDense: true,
                focusedBorder: null,
                enabledBorder: null,
                border: InputBorder.none,
              )),
        )),
        SizedBox(
          width: 37,
          height: 37,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: borderSide,
                bottom: borderSide,
                top: borderSide,
              ),
            ),
            child: MouseRegion(
              onEnter: (event) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (event) {
                setState(() {
                  isHovered = false;
                });
              },
              child: AnimatedOpacity(
                opacity: isHovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: widget.headerValue));
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
