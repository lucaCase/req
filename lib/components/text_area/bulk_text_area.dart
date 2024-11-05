import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';
import 'package:req/components/code_editor_field.dart';
import 'package:req/components/tables/editable_table_row.dart';
import 'package:req/utils/language/highlighting/bulk.dart';

class BulkTextArea extends StatefulWidget {
  BulkTextArea({super.key, required this.elements, required this.controller});

  List<EditableTableRow> elements;
  CodeLineEditingController controller;

  @override
  State<BulkTextArea> createState() => _BulkTextAreaState();
}

class _BulkTextAreaState extends State<BulkTextArea> {
  @override
  Widget build(BuildContext context) {
    widget.controller.text = "";
    for (var row in widget.elements) {
      if (row.keyController.text.isNotEmpty &&
          row.valueController.text.isNotEmpty) {
        print(row.isEnabled);
        widget.controller.text +=
            '${!row.isEnabled ? "# " : ""}${row.keyController.text} : ${row.valueController.text}\n';
      }
    }

    return Expanded(
      child: CodeEditorField(
        readOnly: false,
        languageString: "bulk",
        languageMode: langBulk,
        codeController: widget.controller,
      ),
    );
  }
}
