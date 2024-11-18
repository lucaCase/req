import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:req/components/collections/collection_selection_file.dart';
import 'package:req/dto/collection_dto.dart';
import 'package:req/dto/file_dto.dart';

import '../../dto/request_dto.dart';

class CollectionSelectionFolder extends StatefulWidget {
  CollectionSelectionFolder({super.key, required this.collection});

  FileDto collection;

  @override
  State<CollectionSelectionFolder> createState() =>
      _CollectionSelectionFolderState();
}

class _CollectionSelectionFolderState extends State<CollectionSelectionFolder> {
  final ExpansionTileController _controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    if (widget.collection is CollectionDto) {
      CollectionDto coll = widget.collection as CollectionDto;
      if (coll.files.isEmpty) {
        return ListTile(
          hoverColor: Colors.brown,
          leading: const Icon(
            Icons.folder,
            color: Colors.blueGrey,
          ),
          title: Text(widget.collection.name),
          dense: true,
        );
      }
      return Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ContextMenuArea(
          builder: (context) => [
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Add collection"),
              onTap: () {
                setState(() {
                  _controller.expand();
                  (widget.collection as CollectionDto).files.add(CollectionDto(
                      name: "Collection ${coll.files.length + 1}", files: []));
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Add request"),
              onTap: () {
                setState(() {
                  _controller.expand();
                  (widget.collection as CollectionDto).files.add(RequestDto(
                      name: "Request ${coll.files.length + 1}", method: "GET"));
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("Delete"),
              onTap: () {
                setState(() {
                  coll.files.removeLast();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
          child: ExpansionTile(
            dense: true,
            controller: _controller,
            //tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.folder,
              color: Colors.blueGrey,
            ),
            title: Text(widget.collection.name),
            children: [
              for (var i = 0; i < coll.files.length; i++)
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: CollectionSelectionFolder(collection: coll.files[i]),
                ),
            ],
          ),
        ),
      );
    }

    return CollectionSelectionFile(request: widget.collection as RequestDto);
  }
}
