import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/javascript.dart';
import 'package:req/components/code_editor_field.dart';

class ConsoleTest extends StatefulWidget {
  ConsoleTest({super.key});

  @override
  State<ConsoleTest> createState() => _ConsoleTestState();
}

class _ConsoleTestState extends State<ConsoleTest> {
  CodeLineEditingController controller = CodeLineEditingController();

  late JavascriptRuntime flutterJs;

  @override
  Widget build(BuildContext context) {
    flutterJs = initializeJavascriptRuntime();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.run_circle),
          onPressed: () {
            try {
              JsEvalResult jsResult = flutterJs.evaluate(controller.text);
              print('RESULT: ${jsResult.stringResult}');
            } on PlatformException catch (e) {
              print('ERROR: ${e.details}');
            }
          },
        ),
        body: CodeEditorField(
          codeController: controller,
          languageMode: langJavascript,
          languageString: "javascript",
          readOnly: false,
        ));
  }

  JavascriptRuntime initializeJavascriptRuntime() {
    JavascriptRuntime flutterJs = getJavascriptRuntime();
    flutterJs.onMessage("assert", (args) {
      print("assert: $args");
    });
    flutterJs.evaluate("""
    function assertThat(actualResult, expectedResult, testname) {
      let object = {actual: actualResult, expected: expectedResult, testcase: testname};
      sendMessage("assert", JSON.stringify(object));
    }
    """);
    return flutterJs;
  }
}
