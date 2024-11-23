import 'package:req/dto/file_dto.dart';
import 'package:req/dto/request_dto.dart';

class CollectionDto extends FileDto {
  List<FileDto> files;

  CollectionDto({required super.name, required this.files});

  @override
  CollectionDto copyWith({String? name, List<FileDto>? files}) {
    return CollectionDto(
      name: name ?? this.name,
      files: files ?? this.files,
    );
  }

  static CollectionDto fromJson(Map<String, dynamic> json) {
    return CollectionDto(
      name: json["name"] as String,
      files: (json["files"] as List)
          .map((e) => _isCollection(e as Map<String, dynamic>)
              ? CollectionDto.fromJson(e)
              : RequestDto.fromJson(e))
          .toList(),
    );
  }

  static bool _isCollection(Map<String, dynamic> json) {
    return json.containsKey("files");
  }

  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "files": files.map((e) => e.toJson()).toList(),
      };
}
