import 'dart:convert';

class JsonService {
  static String tryDecode(String value) {
    try {
      print(jsonEncode(value));
      return jsonEncode(value);
    } catch (e) {
      rethrow;
    }
  }
}
