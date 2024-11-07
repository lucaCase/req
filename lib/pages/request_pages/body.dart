import 'package:flutter/material.dart';
import 'package:re_editor/re_editor.dart';
import 'package:re_highlight/languages/json.dart';

import '../../components/code_editor_field.dart';

class Body extends StatefulWidget {
  Body({super.key, required this.codeController});

  CodeLineEditingController codeController;

  @override
  State<Body> createState() => _BodyState();

/*var items = [
    CategorizedDropdownItem(
      value: "Text-Based",
      subItems: [
        SubCategorizedDropdownItem(value: "text/plain"),
        SubCategorizedDropdownItem(value: "text/html"),
        SubCategorizedDropdownItem(value: "text/css"),
        SubCategorizedDropdownItem(value: "text/javascript"),
        SubCategorizedDropdownItem(value: "application/javascript"),
        SubCategorizedDropdownItem(value: "text/csv"),
        SubCategorizedDropdownItem(value: "text/markdown"),
      ],
    ),
    CategorizedDropdownItem(
      text: "Application-Based",
      subItems: [
        SubCategorizedDropdownItem(value: "application/json"),
        SubCategorizedDropdownItem(value: "application/xml"),
        SubCategorizedDropdownItem(value: "text/xml"),
      ],
    ),
    CategorizedDropdownItem(
      text: "Form-Based",
      subItems: [
        SubCategorizedDropdownItem(value: "application/x-www-form-urlencoded"),
        SubCategorizedDropdownItem(value: "multipart/form-data"),
      ],
    ),
    CategorizedDropdownItem(text: "Binary-/File-Based", subItems: [
      SubCategorizedDropdownItem(value: "application/octet-stream"),
      SubCategorizedDropdownItem(value: "application/pdf"),
      SubCategorizedDropdownItem(value: "image/png"),
      SubCategorizedDropdownItem(value: "image/jpeg"),
      SubCategorizedDropdownItem(value: "image/gif"),
      SubCategorizedDropdownItem(value: "audio/mpeg"),
      SubCategorizedDropdownItem(value: "audio/ogg"),
      SubCategorizedDropdownItem(value: "video/mp4"),
      SubCategorizedDropdownItem(value: "video/webm"),
    ]),
    CategorizedDropdownItem(text: "Compressed", subItems: [
      SubCategorizedDropdownItem(value: "application/zip"),
      SubCategorizedDropdownItem(value: "application/gzip"),
      SubCategorizedDropdownItem(value: "application/x-tar"),
    ]),
    CategorizedDropdownItem(text: "Application Specific", subItems: [
      SubCategorizedDropdownItem(value: "application/graphql"),
      SubCategorizedDropdownItem(value: "application/vnd.api+json"),
      SubCategorizedDropdownItem(value: "application/ld+json"),
      SubCategorizedDropdownItem(value: "application/x-ndjson"),
    ]),
    CategorizedDropdownItem(text: "Other", subItems: [
      SubCategorizedDropdownItem(value: "application/x-msgpack"),
      SubCategorizedDropdownItem(value: "application/x-protobuf"),
    ])
  ];
  
   */
}

class _BodyState extends State<Body> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        CodeEditorField(
          codeController: widget.codeController,
          readOnly: false,
          languageString: "json",
          languageMode: langJson,
        ),
      ],
    );
  }
}
