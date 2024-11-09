import 'package:flutter/material.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/javascript.dart';

import '../../components/code_editor_field.dart';

class Scripts extends StatefulWidget {
  Scripts({super.key, required this.controller});

  CodeLineEditingController controller;

  @override
  State<Scripts> createState() => _ScriptsState();
}

class _ScriptsState extends State<Scripts> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late JavascriptRuntime flutterJS;

  @override
  void initState() {
    super.initState();
    flutterJS = getJavascriptRuntime();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
          child: TextButton(
              onPressed: () {
                flutterJS.evaluate("let a = 5;");
                print(flutterJS.dartContext);
                print(flutterJS.evaluate("let a = 5"));
              },
              child: Text("data")),
        ),
        CodeEditorField(
          codeController: widget.controller,
          languageMode: langJavascript,
          languageString: "javascript",
          readOnly: false,
        ),
      ],
    );
  }
}
