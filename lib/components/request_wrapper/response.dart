import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';
import 'package:req/components/code_editor_field.dart';
import 'package:req/components/request_wrapper/response_header.dart';
import 'package:req/components/tabs/tab_wrapper.dart';
import 'package:req/dto/response_dto.dart';
import 'package:req/utils/language/language_service.dart';

class Response extends StatefulWidget {
  Response({super.key, this.res, required this.show, required this.onClose});

  ResponseDto? res;
  bool show;
  final VoidCallback onClose;

  @override
  State<Response> createState() => _ResponseState();
}

class _ResponseState extends State<Response> {
  late CodeLineEditingController codeController;

  List<String> tabs = ["", "Raw", "Headers"];

  @override
  void initState() {
    super.initState();
    codeController = CodeLineEditingController();
  }

  @override
  void didUpdateWidget(covariant Response oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.res != null && widget.res != oldWidget.res) {
      var contentType = widget.res!.response.headers["content-type"]!;
      var body = widget.res!.response.body;
      var (controllerText, _, _) =
          LanguageService.getLanguage(contentType, body);

      if (codeController.text != controllerText) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          codeController.text = controllerText;
        });
      }
    }
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show) {
      return const SizedBox();
    }

    if (widget.res == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      var contentType = widget.res!.response.headers["content-type"]!;
      var body = widget.res!.response.body;
      var (controllerText, languageString, languageMode) =
          LanguageService.getLanguage(contentType, body);
      tabs[0] = (languageString ?? "TEXT").toUpperCase();

      if (codeController.text.isEmpty) {
        codeController.text = controllerText;
      }

      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ResponseHeader(
              statusCode: widget.res!.response.statusCode,
              executionTime: widget.res!.executionTime,
              contentLength: widget.res!.response.contentLength!,
              contentType: contentType,
              languageString: languageString ?? "TEXT",
              controllerText: controllerText,
              onClose: widget.onClose,
            ),
            Expanded(
              child: TabWrapper(tabContents: tabs, tabBodies: [
                CodeEditorField(
                  readOnly: true,
                  codeController: codeController,
                  languageString: languageString,
                  languageMode: languageMode,
                ),
                CodeEditorField(
                  codeController: codeController,
                  readOnly: true,
                  languageString: null,
                  languageMode: null,
                ),
                ListView.builder(
                  itemCount: widget.res!.response.headers.length,
                  itemBuilder: (context, index) {
                    var key =
                        widget.res!.response.headers.keys.elementAt(index);
                    var value = widget.res!.response.headers[key]!;
                    return ListTile(
                      title: Text(key),
                      subtitle: Text(value),
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
      );
    }
  }
}
