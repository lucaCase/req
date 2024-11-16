import 'package:req/dto/file_dto.dart';

class RequestDto extends FileDto {
  String? description;
  String? url;
  String method;
  Map<String, String>? params;
  String? body;
  Map<String, String>? headers;
  String? script;
  String? test;

  RequestDto({
    required super.name,
    this.description,
    this.url,
    required this.method,
    this.params,
    this.body,
    this.headers,
    this.script,
    this.test,
  });
}
