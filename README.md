# Personal Expense Manager (Quản lý chi tiêu cá nhân)

## Thông tin sinh viên
- **Họ và tên**: Dương Văn Sang
- **MSSV**: 2221050823
- **Lớp**: DCCTCLC67B

## Giới thiệu
Ứng dụng quản lý chi tiêu cá nhân bằng Flutter. Cho phép người dùng:
- Thêm, sửa, xóa các giao dịch (CRUD)
- Theo dõi tổng thu, tổng chi và số dư
- Lưu dữ liệu cục bộ bằng SharedPreferences
- Giao diện đẹp, trực quan, Material 3
- Có kiểm thử tự động (unit test & widget test)
- Tích hợp CI/CD bằng GitHub Actions

## Công nghệ sử dụng
- **Flutter & Dart**: Xây dựng giao diện người dùng
- **SharedPreferences**: Lưu dữ liệu cục bộ
- **uuid**: Sinh id duy nhất cho giao dịch
- **flutter_test**: Viết kiểm thử tự động
- **GitHub Actions**: CI/CD, tự động chạy kiểm thử

## Cấu trúc thư mục

lib/
├── main.dart
├── models/
│   └── transaction_model.dart
├── services/
│   └── transaction_service.dart
└── screens/
    ├── transaction_list_screen.dart
    └── transaction_form_screen.dart

test/
├── transaction_service_test.dart
└── transaction_list_screen_test.dart


## Hướng dẫn cài đặt và chạy ứng dụng
```bash
1. **Clone repository**
git clone <đường_dẫn_repo_của_bạn>
cd <tên_project>
2. **Cài đặt dependencies**
flutter pub get
3. **Chạy ứng dụng**
flutter run
4. **Chạy kiểm thử tự động**
flutter test
5. Screenshots / Video demo

Ghi lại quá trình CRUD, kiểm thử unit & widget

Video ≤ 5 phút, rõ ràng, dễ hiểu

Tính năng chính

CRUD giao dịch: Thêm, sửa, xóa, xem danh sách

Tổng hợp chi tiêu: Tổng thu, tổng chi, số dư

Kiểm thử tự động: Unit test & Widget test

Lưu trữ cục bộ: SharedPreferences, dữ liệu không mất khi thoát app

CI/CD

GitHub Actions chạy kiểm thử tự động khi push code

Workflow: .github/workflows/ci.yml

Đảm bảo tất cả kiểm thử pass trước khi nộp bài

Báo cáo kết quả

Giao diện Material 3, dễ sử dụng

CRUD đầy đủ, tổng hợp chi tiêu

Unit test & Widget test pass

Lưu dữ liệu bằng SharedPreferences

GitHub Actions chạy kiểm thử thành công

Điểm tự đánh giá: 10/10 (tự điền)