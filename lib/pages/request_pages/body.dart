import 'package:flutter/material.dart';
import 'package:json_editor/json_editor.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return JsonEditor.string(
      jsonString: '{}',
      onValueChanged: (json) {
        print(json);
      },
      openDebug: true,
    );
  }
}
