import 'package:flutter_test/flutter_test.dart';
import 'package:quadratic_solver/services/solver_service.dart';

void main() {
  group('SolverService', () {
    final solver = SolverService();

    test('solves equation with two distinct roots', () {
      final result = solver.solveQuadraticEquation(1, -3, 2);
      expect(result.x1, 2);
      expect(result.x2, 1);
      expect(result.message, '');
    });

    test('solves equation with one root', () {
      final result = solver.solveQuadraticEquation(1, -2, 1);
      expect(result.x1, 1);
      expect(result.x2, 1);
      expect(result.message, '');
    });

    test('solves equation with no real roots', () {
      final result = solver.solveQuadraticEquation(1, 1, 1);
      expect(result.x1, null);
      expect(result.x2, null);
      expect(result.message, 'No real roots');
    });

    test('handles a = 0', () {
      final result = solver.solveQuadraticEquation(0, 1, 1);
      expect(result.x1, null);
      expect(result.x2, null);
      expect(result.message, 'a cannot be zero');
    });
  });
}