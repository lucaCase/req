import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/javascript.dart';
import 'package:req/components/code_editor_field.dart';

class Tests extends StatefulWidget {
  Tests({super.key, required this.controller});

  CodeLineEditingController controller;

  @override
  State<Tests> createState() => _TestsState();
}

class _TestsState extends State<Tests> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CodeEditorField(
      codeController: widget.controller,
      languageString: "javascript",
      languageMode: langJavascript,
      readOnly: false,
    );
  }
}
