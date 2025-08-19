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
  void initState() {
    super.initState();
    // Initialize controllers with provider's current values (if any)
    final provider = context.read<CalculatorProvider>();
    _aController.text = provider.a;
    _bController.text = provider.b;
    _cController.text = provider.c;

    // Add listeners to update provider's state as user types
    _aController.addListener(() {
      context.read<CalculatorProvider>().setA(_aController.text);
    });
    _bController.addListener(() {
      context.read<CalculatorProvider>().setB(_bController.text);
    });
    _cController.addListener(() {
      context.read<CalculatorProvider>().setC(_cController.text);
    });
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    super.dispose();
  }

  void _calculate() {
    // The provider's internal state is already updated by the listeners on the TextEditingControllers.
    // So, we just need to call solveEquation.
    context.read<CalculatorProvider>().solveEquation();
  }

  void _clearInputs() {
    context.read<CalculatorProvider>().clearInputs();
    // Manually clear controllers as well, since they are not directly bound to provider's strings
    _aController.clear();
    _bController.clear();
    _cController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giải Phương Trình Bậc Hai'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearInputs,
            tooltip: 'Xóa tất cả',
          ),
        ],
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
                final QuadraticResult? result = provider.result;
                if (result == null) {
                  return const SizedBox.shrink(); // Ẩn nếu không có kết quả hoặc lỗi
                }

                // Hiển thị thông báo lỗi nếu isError là true
                if (result.isError) {
                  return Text(
                    'Lỗi: ${result.message}', // Sử dụng result.message trực tiếp
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  );
                } else {
                  // Hiển thị kết quả thành công
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
                      // Sử dụng result.toString() để hiển thị kết quả một cách ngắn gọn dựa trên logic của nó
                      Text(
                        result.toString(),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}