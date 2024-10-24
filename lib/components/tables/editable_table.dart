import 'package:flutter/material.dart';
import 'package:req/components/tables/editable_table_row.dart';

import '../../controller/key_store_controller.dart';

class EditableTable extends StatefulWidget {
  EditableTable({super.key, required this.keyStoreController});

  final KeyStoreController keyStoreController;

  @override
  State<EditableTable> createState() => _EditableTableState();
}

class _EditableTableState extends State<EditableTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListenableBuilder(
                  builder: (BuildContext context, Widget? child) {
                    final List<EditableTableRow> rows =
                        widget.keyStoreController.rows;
                    return ListView.builder(itemBuilder: (context, index) {
                      return rows[index];
                    });
                  }, listenable: widget.keyStoreController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
