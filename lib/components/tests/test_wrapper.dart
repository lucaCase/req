import 'package:flutter/material.dart';
import 'package:req/components/tests/test_case.dart';
import 'package:req/dto/test_dto.dart';

class TestWrapper extends StatelessWidget {
  TestWrapper({super.key, required this.cases});

  List<TestDto> cases;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: const Color(0xFF2B2D30),
          child: Column(
            children: [
              for (var i = 0; i < cases.length; i++)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                    child: TestCase(caseDto: cases[i]),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
