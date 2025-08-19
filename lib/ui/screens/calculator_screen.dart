import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadratic_solver/providers/calculator_provider.dart';
import 'package:quadratic_solver/models/quadratic_result.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    super.dispose();
  }

  void _calculate() {
    final provider = context.read<CalculatorProvider>();
    final double? a = double.tryParse(_aController.text);
    final double? b = double.tryParse(_bController.text);
    final double? c = double.tryParse(_cController.text);

    provider.calculateQuadraticEquation(a, b, c);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giải Phương Trình Bậc Hai'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Hệ số a',
                hintText: 'Nhập giá trị cho a (ax²)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Hệ số b',
                hintText: 'Nhập giá trị cho b (bx)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _cController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Hệ số c',
                hintText: 'Nhập giá trị cho c',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
              child: const Text(
                'Giải',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 24.0),
            Consumer<CalculatorProvider>(
              builder: (context, provider, child) {
                if (provider.errorMessage != null) {
                  return Text(
                    'Lỗi: ${provider.errorMessage}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  );
                } else if (provider.result != null) {
                  final QuadraticResult result = provider.result!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kết quả:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      if (result.x1 != null && result.x2 != null)
                        Text(
                          'x1 = ${result.x1!.toStringAsFixed(4)}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      if (result.x1 != null && result.x2 != null)
                        Text(
                          'x2 = ${result.x2!.toStringAsFixed(4)}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      if (result.message != null)
                        Text(
                          result.message!,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                    ],
                  );
                }
                return const SizedBox.shrink(); // Hide if no result or error
              },
            ),
          ],
        ),
      ),
    );
  }
}