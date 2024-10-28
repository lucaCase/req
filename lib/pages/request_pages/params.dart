import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/tables/editable_table.dart';
import '../../components/text_area/indexed_text_area.dart';
import '../../controller/key_store_controller.dart';

class Params extends StatefulWidget {
  Params({super.key, required this.keyStoreController});

  KeyStoreController keyStoreController;

  @override
  State<Params> createState() => _ParamsState();
}

class _ParamsState extends State<Params> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isBulkEdit = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Parameters",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      widget.keyStoreController.resetRows();
                    },
                    icon: const Icon(Icons.delete_outline),
                    tooltip: "Reset",
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isBulkEdit = !isBulkEdit;
                      });
                    },
                    icon: Icon(Icons.edit_note,
                        color: isBulkEdit ? scheme.primary : Colors.black54),
                    tooltip: "Bulk edit",
                  ),
                  IconButton(
                    onPressed: () {
                      widget.keyStoreController.addRow();
                    },
                    icon: const Icon(Icons.add),
                    tooltip: "Add parameter",
                  ),
                ],
              )
            ],
          ),
          (!isBulkEdit
              ? KeyboardListener(onKeyEvent: (event) {
                if (event is KeyDownEvent) {
                  bool isAltPressed = HardwareKeyboard.instance.isAltPressed;
                  bool isPlusPressed = event.logicalKey == LogicalKeyboardKey.equal || event.logicalKey == LogicalKeyboardKey.equal;
                  if (isAltPressed && isPlusPressed) {
                    setState(() {
                      widget.keyStoreController.addRow();
                    });
                  }
                }
          }, focusNode: FocusNode(),child: SizedBox(height: 296, child: EditableTable()),)
              : IndexedTextArea()),
        ],
      ),
    );
  }
}
