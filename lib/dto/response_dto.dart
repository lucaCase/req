import 'package:http/http.dart';

class ResponseDto {
  Response response;
  int executionTime;

  ResponseDto({required this.response, required this.executionTime});

  @override
  String toString() {
    return 'ResponseDto{response: $response, executionTime: $executionTime}';
  }
}