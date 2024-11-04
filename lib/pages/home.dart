import 'package:flutter/material.dart';
import 'package:req/components/buttons/default_text_icon_button.dart';
import 'package:req/components/request_wrapper/request_handler.dart';
import 'package:req/components/side-navigation/side_navigation_rail.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  List<Widget> pages = [
    RequestHandler(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

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
        body: Row(
          children: [
            SideNavigationRail(
                selectedIndex: selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                }),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: pages[selectedIndex]),
          ],
        ));
  }
}
