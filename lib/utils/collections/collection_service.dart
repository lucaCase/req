import 'package:req/dto/request_dto.dart';

class CollectionService {
  static List<RequestDto> collections = [];

  static List<String> get collectionNames =>
      collections.map((e) => e.name).toList();
}
