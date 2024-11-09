import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:re_editor/re_editor.dart';

import '../../components/tables/editable_tables/editable_table.dart';
import '../../components/text_area/bulk_text_area.dart';
import '../../controller/params_key_store_controller.dart';

class Params extends StatefulWidget {
  Params({super.key, required this.keyStoreController});

  ParamsKeyStoreController keyStoreController;

  @override
  State<Params> createState() => _ParamsState();
}

class _ParamsState extends State<Params> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool isBulkEdit = false;
  CodeLineEditingController bulkEditController = CodeLineEditingController();

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
                "Query Parameters",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      widget.keyStoreController.resetRows();
                      bulkEditController.text = "";
                    },
                    icon: const Icon(Icons.delete_outline),
                    tooltip: "Reset",
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isBulkEdit = !isBulkEdit;
                        if (!isBulkEdit) {
                          widget.keyStoreController.resetRows();
                          for (var line
                              in bulkEditController.text.split("\n")) {
                            var parts = line.split(":");
                            if (parts.length == 2) {
                              widget.keyStoreController.addRowWithValues(
                                key: parts[0].trimLeft().replaceAll("#", ""),
                                value: parts[1].trimRight(),
                                isEnabled: parts[0].trim()[0] != "#",
                              );
                            }
                          }
                          if (widget.keyStoreController.rows.length > 1) {
                            widget.keyStoreController.rows.removeAt(0);
                          }
                        }
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
              ? KeyboardListener(
                  onKeyEvent: (event) {
                    if (event is KeyDownEvent) {
                      bool isAltPressed =
                          HardwareKeyboard.instance.isAltPressed;
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
                      child: EditableTable()),
                )
              : BulkTextArea(
                  elements: widget.keyStoreController.rows,
                  controller: bulkEditController,
                )),
        ],
      ),
    );
  }
}
