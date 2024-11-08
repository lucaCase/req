import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'header_table_row.dart';

class HeaderTable extends StatelessWidget {
  HeaderTable({super.key, required this.rows, required this.header});

  List<HeaderTableRow> rows;
  final header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Row(
            children: [
              const Text("Header-List", style: TextStyle(fontSize: 20)),
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: header));
                  },
                  icon: const Icon(Icons.copy))
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return rows[index];
            },
            itemCount: rows.length,
          ),
        ),
      ],
    );
  }
}
