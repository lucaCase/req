import 'package:flutter/material.dart';
import 'package:req/utils/collections/collection_service.dart';

import '../../dto/file_dto.dart';
import 'collection_selection_header.dart';
import 'collection_selection_system.dart';

class CollectionSelection extends StatefulWidget {
  CollectionSelection({super.key});

  @override
  State<CollectionSelection> createState() => _CollectionSelectionState();
}

class _CollectionSelectionState extends State<CollectionSelection> {
  TextEditingController controller = TextEditingController();

  String filter = "";

  List<FileDto>? collectionPreview;

  @override
  Widget build(BuildContext context) {
    collectionPreview = collectionPreview ?? CollectionService.collections;

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
              onFilterChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    collectionPreview = CollectionService.collections;
                    return;
                  }
                  filter = value;
                  collectionPreview = CollectionService.collections
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(filter.toLowerCase()))
                      .toList();
                });
              },
              onAdded: (file) {
                setState(() {
                  CollectionService.collections.add(file);
                  collectionPreview = CollectionService.collections;
                });
              },
              controller: controller,
            ),
            CollectionSelectionSystem(
              collections: collectionPreview!,
            )
          ],
        ),
      ),
    );
  }
}
