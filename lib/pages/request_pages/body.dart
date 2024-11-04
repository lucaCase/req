import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';

import '../../components/code_editor_field.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  CodeLineEditingController codeController = CodeLineEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CodeEditorField(codeController: codeController, readOnly: false);
  }
}
