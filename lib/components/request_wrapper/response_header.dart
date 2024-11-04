import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../utils/directories/path_provider_service.dart';
import '../../utils/os/command_provider_service.dart';

class ResponseHeader extends StatelessWidget {
  ResponseHeader(
      {super.key,
      required this.statusCode,
      required this.executionTime,
      required this.contentLength,
      required this.contentType,
      required this.languageString,
      required this.controllerText});

  int statusCode;
  int executionTime;
  int contentLength;
  String contentType;
  String languageString;
  String controllerText;

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Status: ", style: defaultTextStyle()),
        Text("$statusCode", style: getStyle(code: statusCode ~/ 100)),
        const SizedBox(width: 25),
        Text("Time: ", style: defaultTextStyle()),
        Text("${executionTime}ms",
            style: defaultTextStyle(color: Colors.green)),
        const SizedBox(width: 25),
        Text("Size: ", style: defaultTextStyle()),
        Text("${double.parse((contentLength / 1000).toStringAsFixed(2))} KB",
            style: defaultTextStyle(color: Colors.green)),
        const SizedBox(width: 25),
        Text("Content-Type: ", style: defaultTextStyle()),
        Text(contentType, style: defaultTextStyle(color: Colors.green)),
        const SizedBox(width: 25),
        IconButton(
            tooltip: "Download response body",
            onPressed: () async {
              final downloadsDir = PathProviderService.getDownloadPath();

              String fileName =
                  "response_${DateTime.now().millisecondsSinceEpoch}.$languageString";

              File file = File("$downloadsDir/$fileName");

              await file.writeAsString(controllerText);

              toastification.show(
                type: ToastificationType.info,
                style: ToastificationStyle.flatColored,
                alignment: Alignment.bottomRight,
                title: const Text(
                  "Downloaded response",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                description: RichText(
                  text: TextSpan(
                      text: "Downloaded response under $downloadsDir/$fileName",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                ),
                autoCloseDuration: const Duration(seconds: 4),
                showProgressBar: true,
                pauseOnHover: true,
                applyBlurEffect: true,
                animationDuration: const Duration(milliseconds: 300),
                closeButtonShowType: CloseButtonShowType.none,
                dragToClose: true,
                callbacks: ToastificationCallbacks(
                  onTap: (toastItem) async {
                    String command = CommandProviderService.getStartCommand();
                    Process.run(command, ["$downloadsDir\\$fileName"]);
                  },
                ),
              );
            },
            icon: Icon(
              Icons.download,
              color: Theme.of(context).primaryColor,
            )),
      ],
    );
  }
}
