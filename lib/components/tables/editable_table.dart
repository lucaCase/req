import 'package:flutter/material.dart';
import 'package:req/components/tables/editable_table_row.dart';

class EditableTable extends StatefulWidget {
  EditableTable({super.key, required this.rows});

  List<EditableTableRow> rows;

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
            children: widget.rows,
          ),
        ),
      ],
    );
  }
}
