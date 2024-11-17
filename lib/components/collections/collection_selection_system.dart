import 'package:flutter/material.dart';
import 'package:req/components/collections/collection_selection_folder.dart';
import 'package:req/dto/file_dto.dart';

import '../../dto/collection_dto.dart';
import '../../dto/request_dto.dart';

class CollectionSelectionSystem extends StatelessWidget {
  CollectionSelectionSystem({super.key});

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
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return CollectionSelectionFolder(collection: collections[index]);
      },
      itemCount: collections.length,
    ));
  }
}
