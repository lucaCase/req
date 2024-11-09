import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:req/components/tables/header_table/editable/editable_header_table.dart';
import 'package:req/controller/header_key_store_controller.dart';

class Headers extends StatefulWidget {
  Headers({super.key, required this.keyStoreController});

  HeaderKeyStoreController keyStoreController;

  @override
  State<Headers> createState() => _HeadersState();
}

class _HeadersState extends State<Headers> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Headers",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      widget.keyStoreController.resetRows();
                    },
                    tooltip: "Reset",
                    icon: const Icon(Icons.delete_outline)),
                IconButton(
                    onPressed: () {
                      widget.keyStoreController.addRow();
                    },
                    tooltip: "Add header",
                    icon: const Icon(Icons.add))
              ],
            )
          ],
        ),
        KeyboardListener(
          onKeyEvent: (event) {
            if (event is KeyDownEvent) {
              bool isAltPressed = HardwareKeyboard.instance.isAltPressed;
              bool isPlusPressed =
                  event.logicalKey == LogicalKeyboardKey.equal ||
                      event.logicalKey == LogicalKeyboardKey.equal;
              if (isAltPressed && isPlusPressed) {
                setState(() {
                  widget.keyStoreController.addRow();
                });
              }
            }
          },
          focusNode: FocusNode(),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 296),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: EditableHeaderTable(
                headerKeyStoreController: widget.keyStoreController,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
