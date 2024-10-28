import 'dart:convert';

import 'package:http/http.dart' as http;

class MethodProvider {
  static Function applyMethod(String method) {
    switch (method) {
      case "GET":
        return (url, {Map<String, String>? headers}) => http.get;
      case "POST":
        return (url, {Map<String, String>? headers, Object? body, Encoding? encoding}) => http.post;
      case "PUT":
        return () => "PUT";
      case "DELETE":
        return () => "DELETE";
      default:
        return () => "GET";
    }
  }
}