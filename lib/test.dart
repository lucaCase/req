import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/json.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CodeEditor(
          indicatorBuilder:
              (context, editingController, chunkController, notifier) {
            return Row(
              children: [
                DefaultCodeLineNumber(
                    notifier: notifier, controller: editingController),
                DefaultCodeChunkIndicator(
                    width: 20, controller: chunkController, notifier: notifier)
              ],
            );
          },
          style: CodeEditorStyle(
            codeTheme: CodeHighlightTheme(
                languages: {"json": CodeHighlightThemeMode(mode: langJson)},
                theme: atomOneDarkTheme),
          ),
        ),
      ),
    );
  }
}
