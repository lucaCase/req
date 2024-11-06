import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/key_store_controller.dart';
import 'editable_table_row.dart';

class EditableTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var keyStoreController = Provider.of<KeyStoreController>(context);

    return ReorderableListView.builder(
        buildDefaultDragHandles: false,
        itemBuilder: (context, index) {
          return EditableTableRow(
            index: index,
            key: keyStoreController.rows[index].key,
            keyController: keyStoreController.rows[index].keyController,
            valueController: keyStoreController.rows[index].valueController,
            onDelete: () => keyStoreController.removeRow(index),
            isEnabled: keyStoreController.rows[index].isEnabled,
            onEnable: () => keyStoreController.toggleRow(index),
          );
        },
        itemCount: keyStoreController.rows.length,
        onReorder: (oldIndex, newIndex) {
          keyStoreController.reorderRows(oldIndex, newIndex);
        });
  }
}
