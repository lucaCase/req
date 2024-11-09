import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:re_editor/re_editor.dart';
import 'package:req/components/buttons/default_text_icon_button.dart';
import 'package:req/components/dropdown_input/dropdown_input.dart';
import 'package:req/components/request_wrapper/response.dart';
import 'package:req/components/tables/header_table/editable/editable_header_table_row.dart';
import 'package:req/dto/response_dto.dart';
import 'package:req/pages/rest_pages/auth.dart';
import 'package:req/pages/rest_pages/headers.dart';
import 'package:req/pages/rest_pages/params.dart';
import 'package:req/pages/rest_pages/scripts.dart';
import 'package:req/pages/rest_pages/tests.dart';

import '../../controller/header_key_store_controller.dart';
import '../../controller/params_key_store_controller.dart';
import '../../pages/rest_pages/body.dart';

class Rest extends StatefulWidget {
  Rest({super.key}) {
    tabs = tabContent.map((e) => Tab(text: e)).toList();
  }

  static const requestOptions = [
    "GET",
    "POST",
    "PUT",
    "DELETE",
    "PATCH",
    "OPTIONS"
  ];
  static const tabContent = [
    "Params",
    "Body",
    "Headers",
    "Auth",
    "Scripts",
    "Tests"
  ];
  List<Tab> tabs = [];

  @override
  State<Rest> createState() => _RestState();
}

class _RestState extends State<Rest> with AutomaticKeepAliveClientMixin {
  TextEditingController requestUrlController = TextEditingController();
  CodeLineEditingController bodyController = CodeLineEditingController();
  CodeLineEditingController scriptController = CodeLineEditingController();
  CodeLineEditingController testController = CodeLineEditingController();

  String value = "GET";

  ResponseDto? res;

  bool showResponse = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var keyStoreController = Provider.of<ParamsKeyStoreController>(context);
    var headerKeyStoreController =
        Provider.of<HeaderKeyStoreController>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 800,
                  child: DropdownInput(
                    onEnter: () {
                      sendRequestToServer(
                          keyStoreController, headerKeyStoreController.rows);
                    },
                    options: Rest.requestOptions,
                    controller: requestUrlController,
                    onChanged: (value) => this.value = value,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: DefaultTextIconButton(
                    onPressed: () {
                      sendRequestToServer(
                          keyStoreController, headerKeyStoreController.rows);
                    },
                    icon: const Icon(Icons.send, color: Colors.white),
                    label: const Text(
                      "Send request",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          DefaultTabController(
            length: widget.tabs.length,
            child: Flexible(
              fit: FlexFit.tight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 1000,
                    child: TabBar(tabs: widget.tabs),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: TabBarView(
                      children: [
                        Params(
                          keyStoreController: keyStoreController,
                        ),
                        Body(codeController: bodyController),
                        Headers(
                          keyStoreController: headerKeyStoreController,
                        ),
                        Auth(),
                        Scripts(
                          controller: scriptController,
                        ),
                        Tests(
                          controller: testController,
                        )
                      ],
                    ),
                  ),
                  Response(
                    res: res,
                    show: showResponse,
                    onClose: () {
                      setState(() {
                        showResponse = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendRequestToServer(ParamsKeyStoreController keyStoreController,
      List<EditableHeaderTableRow> rows) {
    Stopwatch stopwatch = Stopwatch()..start();
    setState(() {
      res = null;
      showResponse = true;
    });

    sendRequest(assembleUrl(keyStoreController), value, rows).then((response) {
      setState(() {
        res = ResponseDto(
            response: response, executionTime: stopwatch.elapsedMilliseconds);
      });
    });
  }

  String assembleUrl(ParamsKeyStoreController keyStoreController) {
    String baseUrl = requestUrlController.text;

    for (var row in keyStoreController.rows) {
      if (row.isEnabled) {
        if (row.keyController.text.isEmpty ||
            row.valueController.text.isEmpty) {
          continue;
        }
        if (baseUrl == requestUrlController.text) {
          baseUrl += "?";
        } else {
          baseUrl += "&";
        }
        baseUrl += "${row.keyController.text}=${row.valueController.text}";
      }
    }

    return baseUrl;
  }

  Future<http.Response> sendRequest(
      String url, String method, List<EditableHeaderTableRow> rows) async {
    try {
      var request = http.Request(method, Uri.parse(url));
      request.headers.addAll({"Content-Type": "application/json"});
      if (bodyController.text.isNotEmpty) {
        request.body = bodyController.text;
      }
      for (var row in rows) {
        if (row.isEnabled) {
          if (row.keyController.text.isNotEmpty &&
              row.valueController.text.isNotEmpty) {
            request.headers
                .addAll({row.keyController.text: row.valueController.text});
          }
        }
      }
      return await request.send().then(http.Response.fromStream);
    } catch (e) {
      return http.Response("Error: $e", 500);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
