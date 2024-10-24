import 'package:flutter/material.dart';
import 'package:req/components/tables/editable_table.dart';
import 'package:req/components/text_area/indexed_text_area.dart';

import '../../controller/key_store_controller.dart';

class Params extends StatefulWidget {
  Params({super.key});

  @override
  State<Params> createState() => _ParamsState();
}

class _ParamsState extends State<Params> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isBulkEdit = false;


  final KeyStoreController _keyStoreController = KeyStoreController();

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
                      setState(() {
                        _keyStoreController.resetRows();
                      });
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
                      setState(() {
                        _keyStoreController.addRow();
                      });
                    },
                    icon: const Icon(Icons.add),
                    tooltip: "Add parameter",
                  ),
                ],
              )
            ],
          ),
          (!isBulkEdit
              ? EditableTable(keyStoreController: _keyStoreController,)
              : IndexedTextArea()),
        ],
      ),
    );
  }
}
