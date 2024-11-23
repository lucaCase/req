import 'package:flutter/material.dart';

import '../../dto/collection_dto.dart';
import '../../dto/file_dto.dart';
import '../../dto/request_dto.dart';
import 'collection_selection_header.dart';
import 'collection_selection_system.dart';

class CollectionSelection extends StatefulWidget {
  CollectionSelection({super.key});

  @override
  State<CollectionSelection> createState() => _CollectionSelectionState();
}

class _CollectionSelectionState extends State<CollectionSelection> {
  TextEditingController controller = TextEditingController();

  List<FileDto> collections = [
    CollectionDto(name: "Collection 1", files: [
      CollectionDto(name: "Sub collection 1", files: [
        CollectionDto(name: "Sub collection 1.1", files: [
          RequestDto(name: "Request 1.1.1", method: "GET"),
          RequestDto(name: "Request 1.1.2", method: "POST"),
          RequestDto(name: "Request 1.1.3", method: "PUT"),
        ]),
        CollectionDto(name: "Sub collection 1.2", files: [
          RequestDto(name: "Request 1.2.1", method: "GET"),
          RequestDto(name: "Request 1.2.2", method: "POST"),
          RequestDto(name: "Request 1.2.3", method: "PUT"),
        ]),
      ]),
      RequestDto(name: "Request 1.1", method: "GET"),
      RequestDto(name: "Request 1.2", method: "POST"),
      RequestDto(name: "Request 1.3", method: "PUT"),
    ]),
    CollectionDto(name: "Collection 2", files: [
      RequestDto(name: "Request 2.1", method: "GET"),
      RequestDto(name: "Request 2.2", method: "POST"),
      RequestDto(name: "Request 2.3", method: "PUT"),
    ]),
    CollectionDto(name: "Collection 3", files: [
      RequestDto(name: "Request 3.1", method: "GET"),
      RequestDto(name: "Request 3.2", method: "POST"),
      RequestDto(name: "Request 3.3", method: "PUT"),
    ]),
  ];

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
              onAdded: (file) {
                setState(() {
                  collections.add(file);
                });
              },
              controller: controller,
            ),
            CollectionSelectionSystem(
              collections: collections,
            )
          ],
        ),
      ),
    );
  }
}
