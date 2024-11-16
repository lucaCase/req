import 'package:flutter/material.dart';

import 'collection_selection_header.dart';
import 'collection_selection_system.dart';

class CollectionSelection extends StatelessWidget {
  CollectionSelection({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      )),
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            CollectionSelectionHeader(
              controller: controller,
            ),
            CollectionSelectionSystem()
          ],
        ),
      ),
    );
  }
}
