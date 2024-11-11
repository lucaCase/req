class TestDto {
  final String testCase;
  final dynamic expected;
  final dynamic actual;

  TestDto(
      {required this.testCase, required this.expected, required this.actual});

  @override
  String toString() {
    return 'TestDto{testCase: $testCase, expected: $expected, actual: $actual}';
  }

  TestDto.fromJson(Map<String, dynamic> json)
      : testCase = json['testCase'] as String,
        expected = json['expected'] as dynamic,
        actual = json['actual'] as dynamic;

  Map<String, dynamic> toJson() => {
        'testCase': testCase,
        'expected': expected,
        'actual': actual,
      };
}
