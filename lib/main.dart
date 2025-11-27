import 'package:flutter/material.dart';
import 'presentation/bmi_controller.dart';
import 'presentation/bmi_page.dart';
import 'domain/bmi_usecase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // domain use case injected into controller (simple DI)
    final usecase = CalculateBMI();
    final controller = BmiController(usecase);

    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,

      // Use system theme (light/dark automatic)
      themeMode: ThemeMode.system,

      // Light theme
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        cardColor: Colors.white,
      ),

      // Dark theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF0B0B0B),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B0B0B),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardColor: const Color(0xFF121212),
      ),

      home: BmiPage(controller: controller),
    );
  }
}
