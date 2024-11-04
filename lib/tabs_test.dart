import 'package:flutter/material.dart';
import 'package:req/components/tabs/tab_wrapper.dart';

class TabsTest extends StatelessWidget {
  const TabsTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TabWrapper(
          tabContents: const [
            'Tab 1',
            'Tab 2',
            'Tab 3',
          ],
          tabBodies: const [
            Text('Tab 1 Body'),
            Text('Tab 2 Body'),
            Text('Tab 3 Body'),
          ],
        ),
      ),
    );
  }
}
