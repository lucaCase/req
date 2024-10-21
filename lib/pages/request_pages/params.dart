import 'package:flutter/material.dart';
import 'package:editable/editable.dart';

class Params extends StatelessWidget {
  Params({super.key});

  static const List<dynamic> columns = [
    {'title': 'Key', 'index': 0, 'key': 'name'},
    {'title': 'Value', 'index': 1, 'key': 'value'},
  ];

  List<dynamic> rows = [
    {'name': '', 'value': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Editable(
      columns: columns,
      rows: rows
    );
  }
}
