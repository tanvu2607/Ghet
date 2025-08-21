import 'package:flutter/material.dart';
import '../services/solver_service.dart';
import '../models/quadratic_result.dart';

class CalculatorProvider with ChangeNotifier {
  final SolverService _solverService = SolverService();
  double a = 0;
  double b = 0;
  double c = 0;
  QuadraticResult result = QuadraticResult(message: '');

  void setA(double value) {
    a = value;
    notifyListeners();
  }

  void setB(double value) {
    b = value;
    notifyListeners();
  }

  void setC(double value) {
    c = value;
    notifyListeners();
  }

  void calculate() {
    result = _solverService.solveQuadraticEquation(a, b, c);
    notifyListeners();
  }
}