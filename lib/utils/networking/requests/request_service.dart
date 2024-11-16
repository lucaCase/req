import 'package:re_editor/re_editor.dart';
import 'package:http/http.dart' as http;
import '../../../components/tables/header_table/editable/editable_header_table_row.dart';

class RequestService {
  static Future<http.Response> sendRequest(
      String url,
      String method,
      List<EditableHeaderTableRow> rows,
      CodeLineEditingController bodyController) async {
    try {
      var request = http.Request(method, Uri.parse(url));
      request.headers.addAll({"Content-Type": "application/json"});
      if (bodyController.text.isNotEmpty) {
        request.body = bodyController.text;
      }
      for (var row in rows) {
        if (row.isEnabled) {
          if (row.keyController.text.isNotEmpty &&
              row.valueController.text.isNotEmpty) {
            request.headers
                .addAll({row.keyController.text: row.valueController.text});
          }
        }
      }

      var streamedResponse = await request.send();

      return await http.Response.fromStream(streamedResponse);
    } on http.ClientException catch (e) {
      return http.Response("Timeout: $e", 408);
    } catch (e) {
      return http.Response("Error: $e", 500);
    }
  }
}
