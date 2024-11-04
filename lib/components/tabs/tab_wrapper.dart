import 'package:flutter/material.dart';
import 'package:hover_widget/hover_widget.dart';
import 'package:req/components/tabs/tab_widget.dart';

class TabWrapper extends StatefulWidget {
  TabWrapper({super.key, required this.tabContents, required this.tabBodies});

  List<String> tabContents = [];

  List<Widget> tabBodies = [];

  @override
  State<TabWrapper> createState() => _TabWrapperState();
}

class _TabWrapperState extends State<TabWrapper> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          child: Row(
            children: widget.tabContents
                .asMap()
                .entries
                .map((e) => HoverWidget(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              index = e.key;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 8, bottom: 8),
                            child: TabWidget(
                              text: e.value,
                              isActive: index != e.key,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: widget.tabBodies[index],
          ),
        ),
      ],
    );
  }
}
