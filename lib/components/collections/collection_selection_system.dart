import 'package:flutter/material.dart';
import 'package:req/components/collections/collection_selection_folder.dart';
import 'package:req/dto/file_dto.dart';

class CollectionSelectionSystem extends StatelessWidget {
  CollectionSelectionSystem({super.key});

  List<FileDto> collections = [];

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
