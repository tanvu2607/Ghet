import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quadratic Solver'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => provider.setA(double.tryParse(value) ?? 0),
              decoration: const InputDecoration(labelText: 'a'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => provider.setB(double.tryParse(value) ?? 0),
              decoration: const InputDecoration(labelText: 'b'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => provider.setC(double.tryParse(value) ?? 0),
              decoration: const InputDecoration(labelText: 'c'),
            ),
            ElevatedButton(
              onPressed: provider.calculate,
              child: const Text('Solve'),
            ),
            Text('Result: ${provider.result.message} x1: ${provider.result.x1}, x2: ${provider.result.x2}'),
          ],
        ),
      ),
    );
  }
}