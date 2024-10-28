import 'package:flutter/material.dart';
import 'package:req/dto/response_dto.dart';

class Response extends StatelessWidget {
  Response({super.key, this.res, required this.show});

  ResponseDto? res;
  bool show;

  @override
  Widget build(BuildContext context) {
    if (!show) {
      return SizedBox();
    }

    if (res == null) {
      return CircularProgressIndicator();
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Text("Status: ${res!.response.statusCode}"),
            Text("Time: ${res!.executionTime}"),
            Text("Size: ${res!.response.contentLength}"),
            Text("Body: ${res!.response.body}"),
          ],
        ),
      );
    }
  }
}
