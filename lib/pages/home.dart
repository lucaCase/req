import 'package:flutter/material.dart';
import 'package:req/components/buttons/default_text_icon_button.dart';
import 'package:req/components/request_wrapper/request_handler.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Container(
          color: Theme.of(context).colorScheme.tertiary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 45,
                      child: DefaultTextIconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {},
                        label: const Text("New Request",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: RequestHandler()
    );
  }
}
