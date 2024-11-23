import 'package:flutter/material.dart';
import 'package:req/components/collections/collection_icon_button.dart';
import 'package:req/dto/file_dto.dart';

import '../../dto/collection_dto.dart';
import '../../dto/request_dto.dart';

class CollectionSelectionHeader extends StatelessWidget {
  CollectionSelectionHeader(
      {super.key, required this.controller, required this.onAdded});

  final TextEditingController controller;

  final ValueChanged<FileDto> onAdded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          CollectionIconButton(
              tooltip: 'New Collection',
              onPressed: () {
                onAdded(CollectionDto(name: 'New Collection', files: []));
              },
              icon: Icons.folder_special_outlined),
          CollectionIconButton(
              tooltip: 'Delete Collection',
              onPressed: () {},
              icon: Icons.folder_delete_outlined),
          CollectionIconButton(
              tooltip: "New Request",
              onPressed: () {
                onAdded(RequestDto(name: 'New Request', method: 'GET'));
              },
              icon: Icons.collections_bookmark_outlined),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
