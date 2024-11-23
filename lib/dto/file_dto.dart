abstract class FileDto {
  String name;

  FileDto({required this.name});

  FileDto copyWith({String? name});

  Map<String, dynamic> toJson();
}
