import 'package:flutter/material.dart';
import 'package:req/components/tables/editable_table.dart';

class Params extends StatefulWidget {
  Params({super.key});

  @override
  State<Params> createState() => _ParamsState();
}

class _ParamsState extends State<Params> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EditableTable();
  }
}
