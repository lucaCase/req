import 'package:req/dto/file_dto.dart';
import 'package:req/dto/request_dto.dart';

import '../../dto/collection_dto.dart';

class CollectionService {
  static List<FileDto> collections = [
    CollectionDto(
        name: "Dir", files: [CollectionDto(name: "Sub Dir 1", files: [])]),
    CollectionDto(
        name: "Dir 2", files: [CollectionDto(name: "Sub Dir 2", files: [])]),
    CollectionDto(
        name: "Dir 3", files: [CollectionDto(name: "Sub Dir 3", files: [])]),
  ];
  static List<String> _collectionNames = [];

  static List<String> getCollectionNames() {
    _collectionNames = [];
    _listCollection("", collections);
    for (var i = 0; i < _collectionNames.length; i++) {
      _collectionNames[i] = _collectionNames[i].substring(1);
    }
    return _collectionNames;
  }

  static void _listCollection(path, List<FileDto> files) {
    for (var file in files) {
      if (file is CollectionDto) {
        _collectionNames.add("$path/${file.name}");
        _listCollection(path + "/" + file.name, file.files);
      }
    }
  }

  static void saveRequest(String wholePath, RequestDto requestDto) {
    List<String> path = wholePath.split("/");
    _saveRequest(path, collections, requestDto);
  }

  static void _saveRequest(
      List<String> pathParts, List<FileDto> files, RequestDto request) {
    if (pathParts.isEmpty) {
      files.add(request);
    } else {
      String path = pathParts.removeAt(0);
      for (var file in files) {
        if (file is CollectionDto) {
          if (path == file.name) {
            _saveRequest(pathParts, file.files, request);
            return;
          }
        }
      }
      var coll = CollectionDto(name: path, files: []);
      files.add(coll);
      _saveRequest(pathParts, coll.files, request);
    }
  }

// Input:
// ---------------------------------
// Sample: "/Root/Sub 4/Sub 4.1/Sub 4.1.1"
// --------------------------------
// Root
// | ------- Sub 1
// |          | ------- Req 1.1
// |          | ------- Req 1.2
// | ------- Sub 2
// | ------- Sub 3
// | ------- Sub 4
//            | ------- Req 4.1
//            | ------- Sub 4.1
//                      | ------- Sub 4.1.1
//                                | ------- Req
//                      | ------- Sub 4.1.2
// ---------------------------------
// Output:
// ---------------------------------
// [
//  "/Root",
//  "/Root/Sub 1",
//  "/Root/Sub 1/Req 1.1",
//  "/Root/Sub 1/Req 1.2",
//  "/Root/Sub 2",
//  "/Root/Sub 3",
//  "/Root/Sub 4",
//  "/Root/Sub 4/Req 4.1",
//  ]
}
