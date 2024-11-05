import 'package:http/http.dart' as http;

class MethodProvider {
  static Function getFunction(String method) {
    switch (method) {
      case "GET":
        return (Uri url) => http.get(url);
      case "POST":
        return (Uri url, {Map<String, String>? headers, dynamic body}) =>
            http.post(url, headers: headers, body: body);
      case "PUT":
        return (Uri url, {Map<String, String>? headers, dynamic body}) =>
            http.put(url, headers: headers, body: body);
      case "DELETE":
        return (Uri url, {Map<String, String>? headers}) =>
            http.delete(url, headers: headers);
      case "PATCH":
        return (Uri url, {Map<String, String>? headers, dynamic body}) =>
            http.patch(url, headers: headers, body: body);
      case "OPTIONS":
        return (Uri url, {Map<String, String>? headers}) async {
          var request = http.Request("OPTIONS", url);
          if (headers != null) request.headers.addAll(headers);

          var streamedResponse = await request.send();
          return http.Response.fromStream(streamedResponse);
        };
      default:
        return (Uri url) => http.get(url);
    }
  }
}