import 'dart:math';

import '../models/quadratic_result.dart';

/// Lớp SolverService chứa logic nghiệp vụ để giải phương trình bậc hai.
/// Phương trình có dạng ax² + bx + c = 0.
class SolverService {
  /// Giải phương trình bậc hai với các hệ số a, b, c.
  ///
  /// Trả về một đối tượng [QuadraticResult] chứa kết quả tính toán.
  ///
  /// Xử lý các trường hợp:
  /// - a = 0: Không phải phương trình bậc hai.
  /// - delta > 0: Hai nghiệm phân biệt.
  /// - delta = 0: Một nghiệm kép.
  /// - delta < 0: Phương trình vô nghiệm thực.
  QuadraticResult solve(double a, double b, double c) {
    // Trường hợp 1: Hệ số 'a' bằng 0
    // Đây không phải là phương trình bậc hai.
    if (a == 0) {
      return QuadraticResult.error("Hệ số 'a' không được bằng 0.");
    }

    // Tính delta (biệt thức)
    final double delta = b * b - 4 * a * c;

    // Trường hợp 2: delta > 0 (Hai nghiệm thực phân biệt)
    if (delta > 0) {
      final double sqrtDelta = sqrt(delta);
      final double x1 = (-b + sqrtDelta) / (2 * a);
      final double x2 = (-b - sqrtDelta) / (2 * a);
      return QuadraticResult.success(x1: x1, x2: x2);
    }
    // Trường hợp 3: delta = 0 (Một nghiệm thực kép)
    else if (delta == 0) {
      final double x = -b / (2 * a);
      return QuadraticResult.success(x1: x, x2: x); // x1 và x2 bằng nhau cho nghiệm kép
    }
    // Trường hợp 4: delta < 0 (Phương trình vô nghiệm thực)
    else {
      return QuadraticResult.noRealRoots();
    }
  }
}