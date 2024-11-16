import 'package:flutter/material.dart';
import 'package:req/dto/file_dto.dart';

class CollectionSelectionFolder extends StatelessWidget {
  CollectionSelectionFolder({super.key, required this.collection});

  FileDto collection;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Colors.brown,
      leading: const Icon(
        Icons.folder,
        color: Colors.blueGrey,
      ),
      title: Text(collection.name),
    );
  }
}

/*
 / folder
 / |-------folder
 / |       |-------folder
 / |       |       |-------folder
 / |       |-------folder
 / |
 /
 /
 /
 */
