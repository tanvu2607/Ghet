/// lib/models/quadratic_result.dart
///
/// Lớp bất biến (immutable) để đóng gói kết quả của phép giải phương trình bậc hai.
/// Chứa các nghiệm (x1, x2), một thông báo mô tả kết quả, và một cờ lỗi.
class QuadraticResult {
  /// Nghiệm thứ nhất của phương trình. Null nếu không có nghiệm thực hoặc chỉ có một nghiệm kép.
  final double? x1;

  /// Nghiệm thứ hai của phương trình. Null nếu không có nghiệm thực hoặc chỉ có một nghiệm kép.
  final double? x2;

  /// Thông báo mô tả kết quả của phép giải (ví dụ: "Hai nghiệm phân biệt", "Nghiệm kép", "Phương trình vô nghiệm", "Lỗi nhập liệu").
  final String message;

  /// Cờ chỉ thị liệu kết quả này có phải là một lỗi (ví dụ: a=0, nhập liệu không hợp lệ).
  final bool isError;

  /// Constructor cho lớp QuadraticResult.
  ///
  /// Tham số:
  /// - [x1]: Nghiệm thứ nhất (tùy chọn).
  /// - [x2]: Nghiệm thứ hai (tùy chọn).
  /// - [message]: Thông báo kết quả (bắt buộc).
  /// - [isError]: Cờ lỗi (mặc định là false).
  const QuadraticResult({
    this.x1,
    this.x2,
    required this.message,
    this.isError = false,
  });

  /// Phương thức tiện ích để tạo một kết quả thành công với hai nghiệm phân biệt.
  factory QuadraticResult.twoRoots(double x1, double x2) {
    return QuadraticResult(
      x1: x1,
      x2: x2,
      message: 'Hai nghiệm phân biệt',
      isError: false,
    );
  }

  /// Phương thức tiện ích để tạo một kết quả thành công với nghiệm kép.
  factory QuadraticResult.doubleRoot(double x) {
    return QuadraticResult(
      x1: x,
      x2: x, // x1 và x2 đều là nghiệm kép
      message: 'Nghiệm kép',
      isError: false,
    );
  }

  /// Phương thức tiện ích để tạo một kết quả thành công khi phương trình vô nghiệm thực.
  factory QuadraticResult.noRealRoots() {
    return const QuadraticResult(
      message: 'Phương trình vô nghiệm',
      isError: false,
    );
  }

  /// Phương thức tiện ích để tạo một kết quả lỗi.
  factory QuadraticResult.error(String errorMessage) {
    return QuadraticResult(
      message: errorMessage,
      isError: true,
    );
  }

  @override
  String toString() {
    if (isError) {
      return 'Lỗi: $message';
    } else if (x1 != null && x2 != null && x1 != x2) {
      return '$message: x1 = ${x1!.toStringAsFixed(4)}, x2 = ${x2!.toStringAsFixed(4)}';
    } else if (x1 != null) {
      return '$message: x = ${x1!.toStringAsFixed(4)}';
    } else {
      return message;
    }
  }
}