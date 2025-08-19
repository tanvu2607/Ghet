# Quadratic Solver

## Giới thiệu

**Quadratic Solver** là một ứng dụng Android native được phát triển bằng Flutter, được thiết kế để giải các phương trình bậc hai có dạng `ax² + bx + c = 0`. Ứng dụng cung cấp một giao diện người dùng đơn giản và trực quan, cho phép người dùng nhập các hệ số `a`, `b`, `c` và nhận kết quả ngay lập tức.

## Chức năng chính

*   **Giải phương trình bậc hai:** Tính toán nghiệm của phương trình `ax² + bx + c = 0`.
*   **Hiển thị kết quả rõ ràng:**
    *   Hai nghiệm phân biệt (x1, x2) nếu delta > 0.
    *   Nghiệm kép (x1 = x2) nếu delta = 0.
    *   Thông báo "Phương trình vô nghiệm" nếu delta < 0.
*   **Xử lý lỗi đầu vào:** Cảnh báo người dùng nếu `a = 0` (không phải phương trình bậc hai) hoặc nếu các giá trị nhập vào không phải là số.

## Cách sử dụng

1.  **Nhập hệ số:** Điền các giá trị số cho `a`, `b`, và `c` vào ba ô nhập liệu tương ứng.
2.  **Nhấn nút "Giải":** Ứng dụng sẽ tính toán và hiển thị kết quả.
3.  **Xem kết quả:** Kết quả (nghiệm hoặc thông báo) sẽ xuất hiện phía dưới nút "Giải".

## Công nghệ và Kiến trúc

*   **Ngôn ngữ lập trình:** Dart (cho Flutter), Kotlin và XML (cho phần vỏ Android native).
*   **Framework:** Flutter SDK.
*   **Kiến trúc:** Ứng dụng tuân thủ **Kiến trúc Sạch (Clean Architecture)**, với sự phân tách rõ ràng giữa các lớp:
    *   **UI (Presentation Layer):** `calculator_screen.dart` chịu trách nhiệm về giao diện người dùng.
    *   **State Management:** Sử dụng thư viện `provider` (`calculator_provider.dart`) để quản lý trạng thái của ứng dụng và thông báo thay đổi cho UI.
    *   **Logic (Domain/Service Layer):** `solver_service.dart` chứa logic tính toán cốt lõi (tính delta và nghiệm), độc lập với UI.
*   **Quản lý phụ thuộc:** `provider` được sử dụng để quản lý trạng thái.
*   **Mô hình dữ liệu:** Lớp `QuadraticResult` bất biến (`immutable`) được sử dụng để đóng gói kết quả tính toán một cách an toàn.
*   **Kiểm thử:** Bao gồm các Unit Test cho lớp `SolverService` để đảm bảo tính đúng đắn của logic tính toán trong các trường hợp khác nhau (delta > 0, delta = 0, delta < 0, a = 0).
*   **Chất lượng mã:** Toàn bộ mã Dart được định dạng bằng `dart format` để đảm bảo tính nhất quán và dễ đọc.
*   **CI/CD:** Tích hợp GitHub Actions để tự động kiểm tra, phân tích, chạy test và build file APK khi có thay đổi mã nguồn.