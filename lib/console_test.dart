import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/javascript.dart';
import 'package:req/components/code_editor_field.dart';
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
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: results[index].actual == results[index].expected
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(results[index].testCase),
                      subtitle: Text(
                          "Actual: ${results[index].actual}, Expected: ${results[index].expected}"),
                    ),
                  );
                },
              ),
            ),
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
