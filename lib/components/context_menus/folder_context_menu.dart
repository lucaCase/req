import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:req/utils/clipboard/clipboard_service.dart';

class FolderContextMenu extends StatefulWidget {
  FolderContextMenu(
      {super.key,
      required this.child,
      this.onDelete,
      this.onAddedCollection,
      this.onAddedRequest,
      this.onRename,
      this.onDuplicate,
      this.onCopy,
      this.onPaste});

  final Widget child;
  final Function? onDelete;
  final Function? onAddedCollection;
  final Function? onAddedRequest;
  final Function? onRename;
  final Function? onDuplicate;
  final Function? onCopy;
  final Function? onPaste;

  @override
  State<FolderContextMenu> createState() => _FolderContextMenuState();
}

class _FolderContextMenuState extends State<FolderContextMenu> {
  @override
  Widget build(BuildContext context) {
    return ContextMenuArea(
        builder: (context) => [
              ListTile(
                enabled: widget.onAddedCollection != null,
                dense: true,
                leading: const Icon(Icons.add),
                title: const Text("Add collection"),
                onTap: () => widget.onAddedCollection!(),
              ),
              ListTile(
                enabled: widget.onAddedRequest != null,
                dense: true,
                leading: const Icon(Icons.add),
                title: const Text("Add request"),
                onTap: () => widget.onAddedRequest!(),
              ),
              const Divider(),
              ListTile(
                  enabled: widget.onDelete != null,
                  dense: true,
                  leading: const Icon(Icons.delete),
                  title: const Text("Delete"),
                  onTap: () => widget.onDelete!()),
              const Divider(),
              ListTile(
                enabled: widget.onRename != null,
                dense: true,
                leading: const Icon(Icons.drive_file_rename_outline),
                title: const Text("Rename"),
                onTap: () => widget.onRename!(),
              ),
              const Divider(),
              ListTile(
                enabled: widget.onDuplicate != null,
                dense: true,
                leading: const Icon(Icons.copy),
                title: const Text("Duplicate"),
                onTap: () => widget.onDuplicate!(),
              ),
              ListTile(
                enabled: widget.onCopy != null,
                dense: true,
                leading: const Icon(Icons.copy),
                title: const Text("Copy"),
                onTap: () => widget.onCopy!(),
              ),
              ListTile(
                enabled: ClipBoardService.hasData() && widget.onPaste != null,
                dense: true,
                leading: const Icon(Icons.paste),
                title: const Text(
                  "Paste",
                ),
                onTap: () => widget.onPaste!(),
              )
            ],
        child: widget.child);
  }
}
