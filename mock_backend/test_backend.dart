import 'dart:convert';
import 'dart:io';

void main() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
  print('Server running on http://${server.address.address}:${server.port}');

  await for (HttpRequest request in server) {
    if (request.uri.path == '/json') {
      final jsonResponse = jsonEncode({'message': 'Hello, JSON!'});
      request.response
        ..headers.contentType = ContentType.json
        ..write(jsonResponse)
        ..close();
    } else {
      request.response
        ..write('Hello, World!')
        ..close();
    }
  }
}
