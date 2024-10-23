import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/java.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class IndexedTextArea extends StatelessWidget {
  IndexedTextArea({super.key});

  final controller = CodeController(
      text:
          'public static void main(String[] args) {\n\tSystem.out.println("Hello, World!");\n}',
      language: java);

  @override
  Widget build(BuildContext context) {
    return CodeTheme(
      data: CodeThemeData(styles: monokaiSublimeTheme),
      child: SingleChildScrollView(
        child: CodeField(
          controller: controller,
        ),
      ),
    );
  }
}
