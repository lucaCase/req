import 'dart:convert';

import 'package:re_highlight/languages/json.dart';
import 'package:re_highlight/languages/xml.dart';
import 'package:re_highlight/languages/yaml.dart';
import 'package:re_highlight/re_highlight.dart';
import 'package:req/utils/language/highlighting/html.dart';
import 'package:xml/xml.dart';

class LanguageService {
  static (String, String?, Mode?) getLanguage(String contentType, String body) {
    var controllerText = body;
    String? languageString;
    Mode? languageMode;
    if (contentType.contains("json")) {
      controllerText = _getPrettyJson(body);
      languageString = "json";
      languageMode = langJson;
    } else if (contentType.contains("xml")) {
      controllerText =
          XmlDocument.parse(body).toXmlString(pretty: true, indent: "    ");
      languageString = "xml";
      languageMode = langXml;
    } else if (contentType.contains("yaml")) {
      languageString = "yaml";
      languageMode = langYaml;
    } else if (contentType.contains("html")) {
      languageString = "html";
      languageMode = langHtml;
    }
    return (controllerText, languageString, languageMode);
  }

  static String _getPrettyJson(String json) {
    var jsonObject = jsonDecode(json);
    return const JsonEncoder.withIndent("    ").convert(jsonObject);
  }
}
