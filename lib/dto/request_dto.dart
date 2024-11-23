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

  @override
  RequestDto copyWith({
    String? name,
    String? description,
    String? url,
    String? method,
    Map<String, String>? params,
    String? body,
    Map<String, String>? headers,
    String? script,
    String? test,
  }) {
    return RequestDto(
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      method: method ?? this.method,
      params: params ?? this.params,
      body: body ?? this.body,
      headers: headers ?? this.headers,
      script: script ?? this.script,
      test: test ?? this.test,
    );
  }

  static FileDto fromJson(Map<String, dynamic> json) {
    return RequestDto(
      name: json["name"] as String,
      description: json["description"] as String?,
      url: json["url"] as String?,
      method: json["method"] as String,
      params: json["params"] as Map<String, String>?,
      body: json["body"] as String?,
      headers: json["headers"] as Map<String, String>?,
      script: json["script"] as String?,
      test: json["test"] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "url": url,
      "method": method,
      "params": params,
      "body": body,
      "headers": headers,
      "script": script,
      "test": test,
    };
  }
}
