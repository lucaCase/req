import 'dart:convert';

class JsonService {
  static String tryEncode(String value) {
    try {
      return jsonEncode(value.replaceAll("\n", ""));
    } catch (e) {
      rethrow;
    }
  }
}
