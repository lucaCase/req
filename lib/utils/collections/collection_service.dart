import 'package:req/dto/file_dto.dart';
import 'package:req/dto/request_dto.dart';

import '../../dto/collection_dto.dart';

class CollectionService {
  static List<FileDto> collections = [];

  static List<String> collectionNames() {
    List<String> names = [];

    for (var collection in collections) {
      if (collection is CollectionDto) {
        names.addAll(_collectionNames(collection));
      }
    }

    return names;
  }

  static List<String> _collectionNames(CollectionDto collection) {
    if (collection.files.isEmpty) {
      return ["/${collection.name}"];
    } else {
      List<String> names = [];
      for (var file in collection.files) {
        if (file is CollectionDto) {
          names.addAll(_collectionNames(file));
        } else {
          names.add("/${collection.name}/${file.name}");
        }
      }
      return names;
    }
  }

  static void saveRequest(String collectionName, RequestDto requestDto) {
    final collection = collections.firstWhere(
      (element) => element.name == collectionName,
      orElse: () => CollectionDto(name: collectionName, files: []),
    );

    (collection as CollectionDto).files.add(requestDto);
  }

// Root
// | ------- Sub 1
// |          | ------- Req 1.1
// |          | ------- Req 1.2
// | ------- Sub 2
// | ------- Sub 3
// | ------- Sub 4
// |          | ------- Req 4.1
}
