import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:highlight/languages/json.dart';

import '../../components/json_editor.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  CodeController? _codeController;

  @override
  void initState() {
    super.initState();

    _codeController = CodeController(
      text: "",
      language: json,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return JsonEditor(codeController: _codeController, readOnly: false);
  }
}
