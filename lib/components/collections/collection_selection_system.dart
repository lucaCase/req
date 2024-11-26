import 'package:flutter/material.dart';
import 'package:req/components/collections/collection_selection_folder.dart';
import 'package:req/dto/file_dto.dart';

class CollectionSelectionSystem extends StatefulWidget {
  CollectionSelectionSystem({super.key, required this.collections});

  List<FileDto> collections;

  @override
  State<CollectionSelectionSystem> createState() =>
      _CollectionSelectionSystemState();
}

class _CollectionSelectionSystemState extends State<CollectionSelectionSystem> {
  FileDto? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: widget.collections.isEmpty
            ? const Center(
                child: Text("There are currently no collections"),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return CollectionSelectionFolder(
                    collection: widget.collections[index],
                    renameCallback: (newName) {
                      setState(() {
                        widget.collections[index].name = newName;
                      });
                    },
                    deleteCallback: () {
                      setState(() {
                        widget.collections.removeAt(index);
                      });
                    },
                    onDuplicate: () {
                      setState(() {
                        FileDto collection = widget.collections[index];
                        widget.collections.insert(
                            index + 1,
                            collection.copyWith(
                                name: "${collection.name} copy"));
                      });
                    },
                  );
                },
                itemCount: widget.collections.length,
              ));
  }
}
