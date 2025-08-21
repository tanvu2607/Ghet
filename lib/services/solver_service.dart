import 'dart:math';

import '../models/quadratic_result.dart';

class SolverService {
  QuadraticResult solveQuadraticEquation(double a, double b, double c) {
    if (a == 0) {
      return QuadraticResult(message: 'a cannot be zero');
    }

    double delta = b * b - 4 * a * c;

    if (delta > 0) {
      double x1 = (-b + sqrt(delta)) / (2 * a);
      double x2 = (-b - sqrt(delta)) / (2 * a);
      return QuadraticResult(x1: x1, x2: x2, message: '');
    } else if (delta == 0) {
      double x = -b / (2 * a);
      return QuadraticResult(x1: x, x2: x, message: '');
    } else {
      return QuadraticResult(message: 'No real roots');
    }
  }
}