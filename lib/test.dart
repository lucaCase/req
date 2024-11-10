import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/themes/atom-one-dark-reasonable.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/javascript.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late JavascriptRuntime flutterJs;

  String _jsResult = '';

  CodeLineEditingController editingController = CodeLineEditingController();

  @override
  void initState() {
    super.initState();
    flutterJs = getJavascriptRuntime();
    flutterJs.evaluate('let a = 5');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            try {
              List<String> codeLines = editingController.text.split(';');

              List<String> results = [];

              for (String line in codeLines) {
                if (line.trim().isNotEmpty) {
                  JsEvalResult jsResult = flutterJs.evaluate(line);
                  results.add(jsResult.stringResult);
                }
              }
              print('RESULTS: $results');
            } on PlatformException catch (e) {
              print('ERROR: ${e.details}');
            }
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Expanded(
              child: CodeEditor(
                scrollController: CodeScrollController(
                  verticalScroller: ScrollController(),
                  horizontalScroller: ScrollController(),
                ),
                controller: editingController,
                indicatorBuilder:
                    (context, editingController, chunkController, notifier) {
                  return Row(
                    children: [
                      DefaultCodeLineNumber(
                        notifier: notifier,
                        controller: editingController,
                      ),
                      DefaultCodeChunkIndicator(
                        width: 20,
                        controller: chunkController,
                        notifier: notifier,
                      ),
                    ],
                  );
                },
                style: CodeEditorStyle(
                  codeTheme: CodeHighlightTheme(
                    languages: {
                      "javascript":
                          CodeHighlightThemeMode(mode: langJavascript),
                    },
                    theme: atomOneDarkReasonableTheme,
                  ),
                ),
              ),
            ),
            Expanded(child: Text(_jsResult)),
          ],
        ),
      ),
    );
  }
}
