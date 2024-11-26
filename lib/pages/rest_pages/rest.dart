import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:provider/provider.dart';
import 'package:re_editor/re_editor.dart';
import 'package:req/components/buttons/default_text_icon_button.dart';
import 'package:req/components/dropdown_input/dropdown_input.dart';
import 'package:req/components/request_wrapper/response.dart';
import 'package:req/components/tables/header_table/editable/editable_header_table_row.dart';
import 'package:req/dto/request_dto.dart';
import 'package:req/dto/response_dto.dart';
import 'package:req/pages/rest_pages/sub_pages/auth.dart';
import 'package:req/pages/rest_pages/sub_pages/headers.dart';
import 'package:req/pages/rest_pages/sub_pages/params.dart';
import 'package:req/pages/rest_pages/sub_pages/scripts.dart';
import 'package:req/pages/rest_pages/sub_pages/tests.dart';
import 'package:req/utils/collections/collection_service.dart';
import 'package:req/utils/networking/requests/request_service.dart';
import 'package:req/utils/networking/url/url_service.dart';

import '../../components/tabs/tab_wrapper.dart';
import '../../controller/header_key_store_controller.dart';
import '../../controller/params_key_store_controller.dart';
import 'sub_pages/body.dart';

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
    "Tests",
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
  String _jsResult = "";
  ResponseDto? res;

  bool showResponse = false;
  late JavascriptRuntime flutterJs;

  FocusNode node = FocusNode();
  TextEditingController collectionNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    flutterJs = getJavascriptRuntime();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var keyStoreController = Provider.of<ParamsKeyStoreController>(context);
    var headerKeyStoreController =
        Provider.of<HeaderKeyStoreController>(context);

    return Focus(
      focusNode: node,
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (HardwareKeyboard.instance.logicalKeysPressed
                  .contains(LogicalKeyboardKey.controlLeft) &&
              event.logicalKey == LogicalKeyboardKey.keyS) {
            openSaveDialogue();
          }
        }
        return KeyEventResult.handled;
      },
      child: Center(
        child: Row(
          children: [
            Expanded(
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
                              sendRequestToServer(keyStoreController,
                                  headerKeyStoreController.rows);
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
                              sendRequestToServer(keyStoreController,
                                  headerKeyStoreController.rows);
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
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: TabWrapper(
                            tabContents: Rest.tabContent,
                            tabBodies: [
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
                              ),
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
                ],
              ),
            ),
          ],
        ),
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

    RequestService.sendRequest(
            UrlService.assembleUrl(keyStoreController, requestUrlController),
            value,
            rows,
            bodyController)
        .then((response) {
      setState(() {
        res = ResponseDto(
            response: response, executionTime: stopwatch.elapsedMilliseconds);
        if (response.statusCode != 200 || response.body.isEmpty) {
          return;
        }
        if (scriptController.text.isEmpty) {
          return;
        }
        flutterJs = getJavascriptRuntime();
        flutterJs.onMessage("luca", (args) {
          print("JS MESSAGE: $args");
        });
        String text = "let res = ${response.body};\n${scriptController.text}";
        JsEvalResult result = flutterJs.evaluate(text);
        _jsResult = result.stringResult;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  void openSaveDialogue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Save request in Collection"),
          content: DropDownSearchField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: collectionNameController,
              decoration: const InputDecoration(
                labelText: "Collection name",
              ),
            ),
            suggestionsCallback: (String pattern) {
              return CollectionService.getCollectionNames()
                  .where((element) =>
                      element.toLowerCase().contains(pattern.toLowerCase()))
                  .toList();
            },
            onSuggestionSelected: (suggestion) {
              collectionNameController.text = suggestion.toString();
            },
            itemBuilder: (context, itemData) {
              return ListTile(
                leading: const Icon(
                  Icons.folder,
                  color: Colors.blueGrey,
                ),
                title: Text(itemData.toString()),
              );
            },
            displayAllSuggestionWhenTap: true,
            layoutArchitecture: (items, scrollController) {
              return ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  children: items.toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  setState(() {
                    saveToCollection(collectionNameController.text);
                  });
                  Navigator.pop(context);
                },
                child: const Text("Save"))
          ],
        );
      },
    );
  }

  void saveToCollection(String collectionName) {
    CollectionService.saveRequest(
        collectionName,
        RequestDto(
            name: collectionName,
            method: value,
            url: requestUrlController.text,
            body: bodyController.text,
            script: scriptController.text,
            test: testController.text));
  }
}
