import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:req/pages/home.dart';
import 'package:req/test.dart';
import 'package:toastification/toastification.dart';

import 'controller/key_store_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => KeyStoreController(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  static const String homeRoute = '/';
  static const String testRoute = '/test';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primary: const Color(0xFFE1693B),
            secondary: const Color(0xFFD15929),
            tertiary: const Color(0xFF2B2D30),
          ),
          useMaterial3: true,
        ),
        initialRoute: testRoute,
        routes: {
          homeRoute: (context) => const Home(),
          testRoute: (context) => const Test(),
        },
      ),
    );
  }
}
