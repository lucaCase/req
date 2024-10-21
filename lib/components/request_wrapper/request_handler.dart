import 'package:flutter/material.dart';
import 'package:req/components/buttons/default_text_icon_button.dart';
import 'package:req/components/dropdown_input/dropdown_input.dart';
import 'package:req/pages/request_pages/auth.dart';
import 'package:req/pages/request_pages/body.dart';
import 'package:req/pages/request_pages/headers.dart';
import 'package:req/pages/request_pages/params.dart';
import 'package:req/pages/request_pages/scripts.dart';
import 'package:req/pages/request_pages/tests.dart';

class RequestHandler extends StatelessWidget {
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
    "Tests"
  ];
  List<Tab> tabs = [];

  @override
  Widget build(BuildContext context) {
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
                  child: DropdownInput(options: requestOptions),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: DefaultTextIconButton(
                    onPressed: () {},
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
            child: Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: 1000,
                    child: TabBar(tabs: tabs),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Params(),
                        Body(),
                        Headers(),
                        Auth(),
                        Scripts(),
                        Tests()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
