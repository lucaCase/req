import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  /*
  late JavascriptRuntime flutterJs;

  @override
  void initState() {
    super.initState();
    flutterJs = getJavascriptRuntime();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print(flutterJs);
            JsEvalResult jsEvalResult = flutterJs
                .evaluate("Math.trunc(Math.random() * 100).toString();");
            print(jsEvalResult.stringResult);
          },
          child: const Icon(Icons.add),
        ),
        body: CodeEditor(
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
                "javascript": CodeHighlightThemeMode(mode: langJavascript),
              },
              theme: atomOneDarkReasonableTheme,
            ),
          ),
        ),
      ),
    );
  }

   */
  String _jsResult = '';
  late JavascriptRuntime flutterJs;

  @override
  void initState() {
    super.initState();

    flutterJs = getJavascriptRuntime();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlutterJS Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('JS Evaluate Result: $_jsResult\n'),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                    'Click on the big JS Yellow Button to evaluate the expression bellow using the flutter_js plugin'),
              ),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Math.trunc(Math.random() * 100).toString();",
                  style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.javascript, color: Colors.yellow),
          onPressed: () async {
            try {
              String jsString =
                  "let a = [10, -6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4];a.sort();a";
              JsEvalResult jsResult = flutterJs.evaluate(jsString);
              setState(() {
                _jsResult = jsResult.stringResult;
              });
            } on PlatformException catch (e) {
              print('ERROR: ${e.details}');
            }
          },
        ),
      ),
    );
  }
}
