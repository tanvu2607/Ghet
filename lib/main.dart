import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadratic_solver/providers/calculator_provider.dart';
import 'package:quadratic_solver/ui/screens/calculator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorProvider(),
      child: MaterialApp(
        title: 'Quadratic Solver',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const CalculatorScreen(),
      ),
    );
  }
}