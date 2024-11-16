import 'package:flutter/cupertino.dart';

import '../../../controller/params_key_store_controller.dart';

class UrlService {
  static String assembleUrl(ParamsKeyStoreController keyStoreController,
      TextEditingController requestUrlController) {
    String baseUrl = requestUrlController.text;

    for (var row in keyStoreController.rows) {
      if (row.isEnabled) {
        if (row.keyController.text.isEmpty ||
            row.valueController.text.isEmpty) {
          continue;
        }
        if (baseUrl == requestUrlController.text) {
          baseUrl += "?";
        } else {
          baseUrl += "&";
        }
        baseUrl += "${row.keyController.text}=${row.valueController.text}";
      }
    }

    return baseUrl;
  }
}
