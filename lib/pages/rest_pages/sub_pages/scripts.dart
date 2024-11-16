import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/javascript.dart';

import '../../../components/code_editor_field.dart';

class Scripts extends StatefulWidget {
  Scripts({super.key, required this.controller});

  CodeLineEditingController controller;

  @override
  State<Scripts> createState() => _ScriptsState();
}

class _ScriptsState extends State<Scripts> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CodeEditorField(
      codeController: widget.controller,
      languageMode: langJavascript,
      languageString: "javascript",
      readOnly: false,
    );
  }
}
