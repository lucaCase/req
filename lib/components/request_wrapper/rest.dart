import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:req/components/buttons/default_text_icon_button.dart';
import 'package:req/components/dropdown_input/dropdown_input.dart';
import 'package:req/components/request_wrapper/response.dart';
import 'package:req/dto/response_dto.dart';
import 'package:req/pages/request_pages/auth.dart';
import 'package:req/pages/request_pages/headers.dart';
import 'package:req/pages/request_pages/params.dart';
import 'package:req/pages/request_pages/scripts.dart';
import 'package:req/pages/request_pages/tests.dart';
import 'package:req/utils/methods/method_provider.dart';

import '../../controller/key_store_controller.dart';
import '../../pages/request_pages/body.dart';

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

  String value = "GET";

  ResponseDto? res;

  bool showResponse = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                        Body(),
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

  void sendRequestToServer(KeyStoreController keyStoreController) {
    Stopwatch stopwatch = Stopwatch()..start();
    setState(() {
      res = null;
      showResponse = true;
    });

    sendRequest(assembleUrl(keyStoreController), value).then((response) {
      setState(() {
        res = ResponseDto(
            response: response, executionTime: stopwatch.elapsedMilliseconds);
      });
    });
  }

  String assembleUrl(KeyStoreController keyStoreController) {
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
        print(baseUrl);
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

  @override
  bool get wantKeepAlive => true;
}