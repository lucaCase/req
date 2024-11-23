class ClipBoardService {
  static Map<String, dynamic> _data = {};

  static void setData(Map<String, dynamic> data) {
    _data = data;
  }

  static Map<String, dynamic> getData() {
    return _data;
  }

  static bool hasData() {
    return _data.isNotEmpty;
  }
}
