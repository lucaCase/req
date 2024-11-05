import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/atom-one-dark-reasonable.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/re_highlight.dart';

class CodeEditorField extends StatefulWidget {
  CodeEditorField(
      {super.key,
      this.readOnly = false,
      required this.codeController,
      this.languageString,
      this.languageMode});

  CodeLineEditingController codeController;
  bool readOnly;
  String? languageString;
  Mode? languageMode;

  @override
  State<CodeEditorField> createState() => _CodeEditorFieldState();
}

class _CodeEditorFieldState extends State<CodeEditorField>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 300,
      child: CodeEditor(
        readOnly: widget.readOnly,
        scrollController: CodeScrollController(
          verticalScroller: ScrollController(),
          horizontalScroller: ScrollController(),
        ),
        controller: widget.codeController,
        indicatorBuilder:
            (context, editingController, chunkController, notifier) {
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                DefaultCodeLineNumber(
                    notifier: notifier, controller: editingController),
                DefaultCodeChunkIndicator(
                    width: 20, controller: chunkController, notifier: notifier)
              ],
            ),
          );
        },
        style: CodeEditorStyle(
          codeTheme: widget.languageString == null
              ? null
              : CodeHighlightTheme(
                  languages: {
                    widget.languageString!:
                        CodeHighlightThemeMode(mode: widget.languageMode!),
                  },
                  theme: atomOneDarkReasonableTheme,
                ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
