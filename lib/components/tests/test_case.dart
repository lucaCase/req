import 'package:flutter/material.dart';
import 'package:req/components/icons/circled_icon.dart';
import 'package:req/dto/test_dto.dart';

class TestCase extends StatelessWidget {
  TestCase({super.key, required this.caseDto});

  TestDto caseDto;

  @override
  Widget build(BuildContext context) {
    var passed = caseDto.expected == caseDto.actual;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: passed
              ? const CircledIcon(icon: Icons.check, color: Colors.green)
              : const CircledIcon(icon: Icons.close, color: Color(0xFFE5BC5B)),
        ),
        Text(
          passed
              ? caseDto.testCase
              : "${caseDto.testCase} | AssertionError: Expected ${caseDto.expected}, got ${caseDto.actual}",
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
