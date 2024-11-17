import 'package:flutter/material.dart';
import 'package:req/dto/collection_dto.dart';
import 'package:req/dto/file_dto.dart';
import 'package:req/utils/colors/color_service.dart';

import '../../dto/request_dto.dart';

class CollectionSelectionFolder extends StatelessWidget {
  CollectionSelectionFolder({super.key, required this.collection});

  FileDto collection;

  @override
  Widget build(BuildContext context) {
    if (collection is CollectionDto) {
      CollectionDto coll = collection as CollectionDto;
      if (coll.files.isEmpty) {
        return ListTile(
          hoverColor: Colors.brown,
          leading: const Icon(
            Icons.folder,
            color: Colors.blueGrey,
          ),
          title: Text(collection.name),
        );
      }
      return Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          //tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          leading: const Icon(
            Icons.folder,
            color: Colors.blueGrey,
          ),
          title: Text(collection.name),
          children: [
            for (var i = 0; i < coll.files.length; i++)
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: CollectionSelectionFolder(collection: coll.files[i]),
              ),
          ],
        ),
      );
    }

    var req = collection as RequestDto;

    return ListTile(
      hoverColor: Colors.brown,
      leading: Text(
        req.method,
        style: TextStyle(color: ColorService.colorsMap[req.method]),
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
