import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:req/components/buttons/default_text_icon_button.dart';
import 'package:req/components/dropdown_input/dropdown_input.dart';
import 'package:http/http.dart' as http;
import 'package:req/components/tables/editable_table_row.dart';
import 'package:req/pages/request_pages/auth.dart';
import 'package:req/pages/request_pages/body.dart';
import 'package:req/pages/request_pages/headers.dart';
import 'package:req/pages/request_pages/params.dart';
import 'package:req/pages/request_pages/scripts.dart';
import 'package:req/pages/request_pages/tests.dart';

import '../../controller/key_store_controller.dart';

class RequestHandler extends StatelessWidget {
  RequestHandler({super.key}) {
    tabs = tabContent.map((e) => Tab(text: e)).toList();
    value = requestOptions[0];
  }

  TextEditingController requestUrlController = TextEditingController();

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

  String value = "";

  @override
  Widget build(BuildContext context) {


    var keyStoreController = Provider.of<KeyStoreController>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 800,
                  child: DropdownInput(options: requestOptions, controller: requestUrlController, onChanged: (value) => this.value = value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: DefaultTextIconButton(
                    onPressed: () {
                      if (value == "GET") {
                        Stopwatch stopwatch = Stopwatch()..start();

                        http.get(Uri.parse(assembleUrl(keyStoreController.rows))).then((value) {
                          print(value.headers);
                          print("GET executed in ${stopwatch.elapsed.inMilliseconds}ms");
                        });
                      }
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
            length: tabs.length,
            child: Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 1000,
                    child: TabBar(tabs: tabs),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: TabBarView(
                      children: [
                        Params(keyStoreController: keyStoreController,),
                        Body(),
                        Headers(),
                        Auth(),
                        Scripts(),
                        Tests()
                      ],
                    ),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String assembleUrl(List<EditableTableRow> rows) {
    String baseUrl = requestUrlController.text;

    for (var row in rows) {
      if (row.isEnabled) {
        String key = ":${row.keyController.text}";
        String value = row.valueController.text;

        baseUrl = baseUrl.replaceAll(key, value);
      }
    }

    return baseUrl;
  }
}
