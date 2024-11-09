import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/json.dart';

import '../../components/code_editor_field.dart';

class Body extends StatefulWidget {
  Body({super.key, required this.codeController});

  CodeLineEditingController codeController;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CodeEditorField(
      codeController: widget.codeController,
      readOnly: false,
      languageString: "json",
      languageMode: langJson,
    );
  }
}
