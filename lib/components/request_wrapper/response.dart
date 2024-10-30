import 'dart:convert';

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:highlight/languages/json.dart';
import 'package:req/components/json_editor.dart';
import 'package:req/dto/response_dto.dart';

class Response extends StatefulWidget {
  Response({super.key, this.res, required this.show});

  ResponseDto? res;
  bool show;

  @override
  State<Response> createState() => _ResponseState();
}

class _ResponseState extends State<Response> {
  Map<int, TextStyle> codeColors = {
    1: const TextStyle(
        color: Colors.green, fontWeight: FontWeight.w500, fontSize: 18),
    2: const TextStyle(
        color: Colors.green, fontWeight: FontWeight.w500, fontSize: 18),
    3: const TextStyle(
        color: Colors.green, fontWeight: FontWeight.w500, fontSize: 18),
    4: const TextStyle(
        color: Colors.red, fontWeight: FontWeight.w500, fontSize: 18),
    5: const TextStyle(
        color: Colors.red, fontWeight: FontWeight.w500, fontSize: 18),
  };

  TextStyle getStyle({required int code}) {
    return codeColors[code] ??
        const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18);
  }

  TextStyle defaultTextStyle({Color color = Colors.black}) =>
      TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 18);

  CodeController? _codeController;

  @override
  void initState() {
    super.initState();

    _codeController = CodeController(
      language: json,
    );
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show) {
      return const SizedBox();
    }

    if (widget.res == null) {
      return const CircularProgressIndicator();
    } else {
      var contentType = widget.res!.response.headers["content-type"];
      var body = widget.res!.response.body;

      if (contentType! == "application/json") {
        _codeController!.text = getPrettyJson(body);
      } else {
        _codeController!.text = body;
      }
      return Column(
        children: [
          Row(
            children: [
              Text("Status: ", style: defaultTextStyle()),
              Text("${widget.res!.response.statusCode}",
                  style:
                      getStyle(code: widget.res!.response.statusCode ~/ 100)),
              const SizedBox(width: 25),
              Text("Time: ", style: defaultTextStyle()),
              Text("${widget.res!.executionTime}ms",
                  style: defaultTextStyle(color: Colors.green)),
              const SizedBox(width: 25),
              Text("Size: ", style: defaultTextStyle()),
              Text(
                  "${double.parse((widget.res!.response.contentLength! / 1000).toStringAsFixed(2))} KB",
                  style: defaultTextStyle(color: Colors.green)),
              const SizedBox(width: 25),
              Text("Content-Type: ", style: defaultTextStyle()),
              Text("$contentType",
                  style: defaultTextStyle(color: Colors.green)),
            ],
          ),
          JsonEditor(
            readOnly: true,
            codeController: _codeController,
          )
        ],
      );
    }
  }

  String getPrettyJson(String json) {
    var jsonObject = jsonDecode(json);
    return const JsonEncoder.withIndent("    ").convert(jsonObject);
  }
}
