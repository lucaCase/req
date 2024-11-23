import 'package:flutter/material.dart';
import 'package:req/components/collections/collection_selection_file.dart';
import 'package:req/components/context_menus/folder_context_menu.dart';
import 'package:req/dto/collection_dto.dart';
import 'package:req/dto/file_dto.dart';
import 'package:req/utils/clipboard/clipboard_service.dart';

import '../../dto/request_dto.dart';

class CollectionSelectionFolder extends StatefulWidget {
  CollectionSelectionFolder({
    super.key,
    required this.collection,
    required this.deleteCallback,
    required this.renameCallback,
    required this.onDuplicate,
  });

  FileDto collection;
  Function deleteCallback;
  ValueChanged<String> renameCallback;
  Function onDuplicate;

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
        return FolderContextMenu(
          onAddedRequest: () => onAddedRequest(context, coll),
          onAddedCollection: () => onAddedCollection(context, coll),
          onRename: () => onRename(context, coll),
          onDelete: () => onDelete(context),
          onDuplicate: () => onDuplicate(context),
          onCopy: () => onCopy(context, coll),
          onPaste: () => onPaste(context, coll),
          child: ListTile(
              leading: const Icon(
                Icons.folder,
                color: Colors.blueGrey,
              ),
              title: Text(widget.collection.name),
              dense: true,
              onTap: () {}),
        );
      }
      return Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: FolderContextMenu(
            onRename: () => onRename(context, coll),
            onDelete: () => onDelete(context),
            onAddedRequest: () => onAddedRequest(context, coll),
            onAddedCollection: () => onAddedCollection(context, coll),
            onDuplicate: () => onDuplicate(context),
            onCopy: () => onCopy(context, coll),
            onPaste: () => onPaste(context, coll),
            child: ExpansionTile(
              dense: true,
              controller: _controller,
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
                    child: CollectionSelectionFolder(
                      collection: coll.files[i],
                      deleteCallback: () {
                        setState(() {
                          coll.files.removeAt(i);
                        });
                      },
                      renameCallback: (newName) {
                        setState(() {
                          coll.files[i].name = newName;
                        });
                      },
                      onDuplicate: () {
                        setState(() {
                          var copy = coll.files[i].copyWith();
                          copy.name = "${coll.files[i].name} copy";
                          coll.files.insert(i + 1, copy);
                        });
                      },
                    ),
                  ),
              ],
            )),
      );
    }

    return FolderContextMenu(
        onRename: () => onRename(context, widget.collection as RequestDto),
        onDelete: () => onDelete(context),
        onDuplicate: () => onDuplicate(context),
        onCopy: () => onCopy(context, widget.collection as RequestDto),
        onPaste: () => onPaste(context, widget.collection as RequestDto),
        child:
            CollectionSelectionFile(request: widget.collection as RequestDto));
  }

  onDelete(context) {
    setState(() {
      widget.deleteCallback();
    });
    Navigator.of(context).pop();
  }

  onAddedRequest(context, coll) {
    setState(() {
      (widget.collection as CollectionDto).files.add(
          RequestDto(name: "Request ${coll.files.length + 1}", method: "GET"));
      _controller.expand();
    });
    Navigator.of(context).pop();
  }

  onAddedCollection(context, coll) {
    setState(() {
      (widget.collection as CollectionDto).files.add(CollectionDto(
          name: "Collection ${coll.files.length + 1}", files: []));
      _controller.expand();
    });
    Navigator.of(context).pop();
  }

  onDuplicate(context) {
    widget.onDuplicate();
    Navigator.of(context).pop();
  }

  onCopy(context, coll) {
    ClipBoardService.setData(coll.toJson());
    Navigator.of(context).pop();
  }

  onPaste(context, coll) {
    var data = ClipBoardService.getData();

    if (data['files'] != null) {
      setState(() {
        (widget.collection as CollectionDto)
            .files
            .add(CollectionDto.fromJson(data));
      });
    } else {
      setState(() {
        (widget.collection as CollectionDto)
            .files
            .add(RequestDto.fromJson(data));
      });
    }

    _controller.expand();

    Navigator.of(context).pop();
  }

  onRename(context, coll) {
    Navigator.of(context).pop();
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController controller = TextEditingController();

          return AlertDialog(
            title: Text("Rename ${coll.name}"),
            content: TextFormField(
              controller: controller,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    widget.renameCallback(controller.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Rename")),
              TextButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: const Text("Cancel"))
            ],
          );
        });
  }
}
