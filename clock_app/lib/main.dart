import 'package:clock_app/utils/route_utils.dart';
import 'package:clock_app/view/screens/clock_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.clockPage: (context) => const ClockPage(),
      },
    );
  }
}
