import 'package:req/dto/file_dto.dart';

class CollectionDto extends FileDto {
  List<FileDto> files;

  CollectionDto({required super.name, required this.files});
}
