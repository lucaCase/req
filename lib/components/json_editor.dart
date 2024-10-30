import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';

class JsonEditor extends StatefulWidget {
  JsonEditor({super.key, this.readOnly = false, required this.codeController});

  CodeController? codeController;

  bool readOnly;

  @override
  State<JsonEditor> createState() => _JsonEditorState();
}

class _JsonEditorState extends State<JsonEditor> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      reverse: true,
      child: SizedBox(
        height: 300,
        child: CodeField(
          controller: widget.codeController!,
          maxLines: null,
          readOnly: widget.readOnly,
          wrap: true,
        ),
      ),
    );
  }
}
