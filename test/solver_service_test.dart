import 'package:flutter_test/flutter_test.dart';
import 'package:quadratic_solver/models/quadratic_result.dart';
import 'package:quadratic_solver/services/solver_service.dart';

void main() {
  group('SolverService', () {
    late SolverService solverService;

    setUp(() {
      solverService = SolverService();
    });

    test('should return two distinct real roots when delta > 0', () {
      // Test case: x^2 - 5x + 6 = 0 => (x-2)(x-3) = 0, roots are 2 and 3
      final result = solverService.solve(1.0, -5.0, 6.0);

      expect(result.isError, isFalse);
      expect(result.x1, closeTo(3.0, 0.0001)); // Using closeTo for double comparison
      expect(result.x2, closeTo(2.0, 0.0001));
      expect(result.message, 'Hai nghiệm phân biệt'); // Correct message
    });

    test('should return one real root (repeated) when delta = 0', () {
      // Test case: x^2 - 4x + 4 = 0 => (x-2)^2 = 0, root is 2
      final result = solverService.solve(1.0, -4.0, 4.0);

      expect(result.isError, isFalse);
      expect(result.x1, closeTo(2.0, 0.0001));
      expect(result.x2, closeTo(2.0, 0.0001));
      expect(result.message, 'Nghiệm kép'); // Correct message
    });

    test('should return "Phương trình vô nghiệm" when delta < 0', () {
      // Test case: x^2 + x + 1 = 0
      final result = solverService.solve(1.0, 1.0, 1.0);

      expect(result.isError, isFalse); // It's not an error, just no real roots
      expect(result.x1, isNull);
      expect(result.x2, isNull);
      expect(result.message, 'Phương trình vô nghiệm');
    });

    test('should return "Hệ số a không được bằng 0" when a = 0', () {
      // Test case: 0x^2 + 2x + 4 = 0 (linear equation, not quadratic)
      final result = solverService.solve(0.0, 2.0, 4.0);

      expect(result.isError, isTrue); // This is an error case
      expect(result.x1, isNull);
      expect(result.x2, isNull);
      expect(result.message, 'Hệ số \'a\' không được bằng 0.'); // Correct message
    });
  });
}