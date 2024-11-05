import 'package:re_highlight/re_highlight.dart';

final langBulk = Mode(
  name: "SimpleLang",
  caseInsensitive: false,
  unicodeRegex: true,
  contains: <Mode>[
    // Handling comments that start with #
    Mode(
      className: 'comment',
      begin: "#",
      end: "\$",
      contains: <Mode>[],
      relevance: 0,
    ),
    // Handling key-value pairs in the form `a : b`
    Mode(
      className: 'key-value',
      begin: "\\b[a-zA-Z_][a-zA-Z0-9_]*\\s*:\\s*",
      end: "(?=#|\$)",
      // Ends at a comment or end of the line
      excludeEnd: true,
      contains: <Mode>[
        Mode(
          className: 'value',
          begin: "\\S+",
          end: "(?=\\s|\$)",
          excludeEnd: true,
        ),
      ],
      relevance: 10,
    ),
  ],
);
