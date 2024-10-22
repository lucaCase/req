import 'package:flutter/material.dart';

class Scripts extends StatefulWidget {
  const Scripts({super.key});

  @override
  State<Scripts> createState() => _ScriptsState();
}

class _ScriptsState extends State<Scripts> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Placeholder();
  }
}
