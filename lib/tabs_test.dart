/*import 'package:categorized_dropdown/categorized_dropdown.dart';
import 'package:flutter/material.dart';

class TabsTest extends StatefulWidget {
  TabsTest({super.key});

  @override
  State<TabsTest> createState() => _TabsTestState();
}

class _TabsTestState extends State<TabsTest> {
  final List<CategorizedDropdownItem<String>> items = [
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

  String value = 'pipes';

  final List<CategorizedDropdownItem<String>>? items1 = [
    CategorizedDropdownItem(text: 'Exhaust', subItems: [
      SubCategorizedDropdownItem(text: 'Pipes', value: 'pipes'),
      SubCategorizedDropdownItem(text: 'Mufflers', value: 'mufflers'),
      SubCategorizedDropdownItem(text: 'Gaskets', value: 'gaskets'),
    ]),
    CategorizedDropdownItem(text: 'Engine Parts', subItems: [
      SubCategorizedDropdownItem(text: 'Engine mounts', value: 'engine-mounts'),
      SubCategorizedDropdownItem(text: 'Oil Filters', value: 'oil-filters'),
    ]),
    CategorizedDropdownItem(text: 'Fuel & Emission', subItems: [
      SubCategorizedDropdownItem(
          text: 'Fuel Injection', value: 'fuel-incection'),
      SubCategorizedDropdownItem(text: '02 Sensor', value: 'o2-sensor'),
    ]),
    CategorizedDropdownItem(text: 'Other', value: 'Other'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CategorizedDropdown(
          items: items,
          value: value,
          hint: const Text('Select auto parts'),
          onChanged: (v) {
            setState(() {
              value = value;
            });
          },
        ),
      ),
    );
  }
}


 */
