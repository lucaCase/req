import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/javascript.dart';
import 'package:req/components/code_editor_field.dart';
import 'package:req/components/tests/test_wrapper.dart';
import 'package:req/dto/test_dto.dart';

class ConsoleTest extends StatefulWidget {
  ConsoleTest({super.key});

  @override
  State<ConsoleTest> createState() => _ConsoleTestState();
}

class _ConsoleTestState extends State<ConsoleTest> {
  CodeLineEditingController controller = CodeLineEditingController();

  late JavascriptRuntime flutterJs;

  @override
  @override
  void initState() {
    flutterJs = initializeJavascriptRuntime();
    controller.text =
        "assertThat(1, 1, '1 equals 1');\nassertThat(1, 2, '1 equals 2');";
    super.initState();
  }

  List<TestDto> results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.run_circle),
          onPressed: () {
            flutterJs = initializeJavascriptRuntime();
            try {
              JsEvalResult jsResult = flutterJs.evaluate(controller.text);
              print('RESULT: ${jsResult.stringResult}');
            } on PlatformException catch (e) {
              print('ERROR: ${e.details}');
            }
          },
        ),
        body: Column(
          children: [
            CodeEditorField(
              codeController: controller,
              languageMode: langJavascript,
              languageString: "javascript",
              readOnly: false,
            ),
            SingleChildScrollView(child: TestWrapper(cases: results)),
          ],
        ));
  }

  JavascriptRuntime initializeJavascriptRuntime() {
    results = [];
    JavascriptRuntime flutterJs = getJavascriptRuntime();
    flutterJs.onMessage("assert", (args) {
      print("assert: ${args}");
      setState(() {
        results.add(TestDto.fromJson(args));
      });
    });
    flutterJs.evaluate("""
    function assertThat(actual, expected, testCase) {
      let object = {actual: actual, expected: expected, testCase: testCase};
      sendMessage("assert", JSON.stringify(object));
    }
    """);
    return flutterJs;
  }
}
