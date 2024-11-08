import 'package:flutter/material.dart';
import 'package:req/components/tables/header_table/editable/editable_header_table_row.dart';

import '../../../../controller/header_key_store_controller.dart';

class EditableHeaderTable extends StatelessWidget {
  const EditableHeaderTable(
      {super.key, required this.headerKeyStoreController});

  final HeaderKeyStoreController headerKeyStoreController;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
        shrinkWrap: true,
        buildDefaultDragHandles: false,
        itemBuilder: (context, index) {
          return EditableHeaderTableRow(
            index: index,
            key: headerKeyStoreController.rows[index].key,
            keyController: headerKeyStoreController.rows[index].keyController,
            valueController:
                headerKeyStoreController.rows[index].valueController,
            onDelete: () => headerKeyStoreController.removeRow(index),
            isEnabled: headerKeyStoreController.rows[index].isEnabled,
            onEnable: () => headerKeyStoreController.toggleRow(index),
          );
        },
        itemCount: headerKeyStoreController.rows.length,
        onReorder: (oldIndex, newIndex) {
          headerKeyStoreController.reorderRows(oldIndex, newIndex);
        });
  }
}
