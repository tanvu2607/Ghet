import 'package:flutter/material.dart';
import '../models/quadratic_result.dart';
import '../services/solver_service.dart';

/// Lớp CalculatorProvider quản lý trạng thái của ứng dụng giải phương trình bậc hai.
/// Nó giữ các giá trị nhập liệu (a, b, c) và kết quả tính toán (QuadraticResult).
/// Lớp này tương tác với SolverService để thực hiện logic giải phương trình
/// và thông báo cho các widget lắng nghe khi trạng thái thay đổi.
class CalculatorProvider extends ChangeNotifier {
  // Các biến lưu trữ giá trị nhập liệu dưới dạng chuỗi
  String _a = '';
  String _b = '';
  String _c = '';

  // Biến lưu trữ kết quả tính toán
  QuadraticResult? _result;

  // Getters để truy cập các giá trị từ bên ngoài
  String get a => _a;
  String get b => _b;
  String get c => _c;
  QuadraticResult? get result => _result;

  /// Cập nhật giá trị của hệ số 'a' và xóa kết quả cũ.
  void setA(String value) {
    if (_a != value) {
      _a = value;
      _result = null; // Xóa kết quả khi có thay đổi đầu vào
      notifyListeners(); // Thông báo cho các widget lắng nghe
    }
  }

  /// Cập nhật giá trị của hệ số 'b' và xóa kết quả cũ.
  void setB(String value) {
    if (_b != value) {
      _b = value;
      _result = null; // Xóa kết quả khi có thay đổi đầu vào
      notifyListeners(); // Thông báo cho các widget lắng nghe
    }
  }

  /// Cập nhật giá trị của hệ số 'c' và xóa kết quả cũ.
  void setC(String value) {
    if (_c != value) {
      _c = value;
      _result = null; // Xóa kết quả khi có thay đổi đầu vào
      notifyListeners(); // Thông báo cho các widget lắng nghe
    }
  }

  /// Thực hiện giải phương trình bậc hai.
  /// Phương thức này sẽ phân tích cú pháp các giá trị nhập liệu,
  /// xử lý lỗi nhập liệu không phải là số, và sau đó gọi SolverService
  /// để tính toán kết quả.
  void solveEquation() {
    _result = null; // Xóa kết quả trước khi tính toán mới

    // Cố gắng phân tích cú pháp các chuỗi nhập liệu thành số double
    final double? parsedA = double.tryParse(_a);
    final double? parsedB = double.tryParse(_b);
    final double? parsedC = double.tryParse(_c);

    // Kiểm tra nếu bất kỳ giá trị nào không phải là số hợp lệ
    if (parsedA == null || parsedB == null || parsedC == null) {
      _result = const QuadraticResult(
        message: 'Vui lòng nhập các giá trị số hợp lệ cho a, b, c.',
        isError: true,
      );
      notifyListeners();
      return;
    }

    // Gọi SolverService để giải phương trình.
    // SolverService sẽ chịu trách nhiệm xử lý các trường hợp như a=0, delta > 0, delta = 0, delta < 0.
    _result = SolverService.solve(parsedA, parsedB, parsedC);
    notifyListeners(); // Thông báo cho các widget lắng nghe khi kết quả đã được cập nhật
  }

  /// Xóa tất cả các trường nhập liệu và kết quả.
  void clearInputs() {
    _a = '';
    _b = '';
    _c = '';
    _result = null;
    notifyListeners();
  }
}