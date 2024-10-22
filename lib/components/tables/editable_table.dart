import 'package:flutter/material.dart';
import 'package:req/components/tables/editable_table_row.dart';

class EditableTable extends StatelessWidget {
  EditableTable({super.key});
  List<EditableTableRow> rows = [
    EditableTableRow(),
  ];

  Map<String, String> getValues() {
    Map<String, String> values = {};
    for (EditableTableRow row in rows) {
      values.addAll(row.getValues());
    }
    return values;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: rows,
      ),
    );
  }
}
