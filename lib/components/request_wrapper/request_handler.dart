import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:req/components/buttons/default_text_icon_button.dart';
import 'package:req/components/dropdown_input/dropdown_input.dart';
import 'package:req/components/request_wrapper/response.dart';
import 'package:req/components/tables/editable_table_row.dart';
import 'package:req/dto/response_dto.dart';
import 'package:req/pages/request_pages/auth.dart';
import 'package:req/pages/request_pages/headers.dart';
import 'package:req/pages/request_pages/params.dart';
import 'package:req/pages/request_pages/scripts.dart';
import 'package:req/pages/request_pages/tests.dart';
import 'package:req/utils/methods/method_provider.dart';

import '../../controller/key_store_controller.dart';

class RequestHandler extends StatefulWidget {
  RequestHandler({super.key}) {
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
    //"Tests"
  ];
  List<Tab> tabs = [];

  @override
  State<RequestHandler> createState() => _RequestHandlerState();
}

class _RequestHandlerState extends State<RequestHandler> {
  TextEditingController requestUrlController = TextEditingController();

  String value = "GET";

  ResponseDto? res;

  bool showResponse = false;

  @override
  Widget build(BuildContext context) {
    var keyStoreController = Provider.of<KeyStoreController>(context);

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
                      sendRequestToServer(keyStoreController);
                    },
                    options: RequestHandler.requestOptions,
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
                      sendRequestToServer(keyStoreController);
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
                        //Body(),
                        Headers(),
                        Auth(),
                        Scripts(),
                        Tests()
                      ],
                    ),
                  ),
                  Response(
                    res: res,
                    show: showResponse,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendRequestToServer(KeyStoreController keyStoreController) {
    Stopwatch stopwatch = Stopwatch()..start();
    setState(() {
      res = null;
      showResponse = true;
    });

    sendRequest(assembleUrl(keyStoreController.rows), value).then((value) {
      setState(() {
        res = ResponseDto(
            response: value, executionTime: stopwatch.elapsedMilliseconds);
      });
    });
  }

  String assembleUrl(List<EditableTableRow> rows) {
    String baseUrl = requestUrlController.text;

    for (var row in rows) {
      if (row.isEnabled) {
        if (row.keyController.text.isEmpty ||
            row.valueController.text.isEmpty) {
          continue;
        }
        String key = ":${row.keyController.text}";
        String value = row.valueController.text;

        baseUrl = baseUrl.replaceAll(key, value);
      }
    }

    return baseUrl;
  }

  Future<http.Response> sendRequest(String url, String method) async {
    var function = MethodProvider.getFunction(method);
    try {
      return await function(Uri.parse(url));
    } catch (e) {
      return http.Response("Error: $e", 500);
    }
  }
}
