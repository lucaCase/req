import 'package:flutter/material.dart';
import 'package:req/components/dropdown_input/dropdown_input.dart';
import 'package:req/components/request_wrapper/request_handler.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Container(
          color: Theme.of(context).colorScheme.tertiary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 45,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text("New Request", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: DropdownInput(options: const ["GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"]),
      ),
    );
  }
}
