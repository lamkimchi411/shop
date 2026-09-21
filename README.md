# Aodai Shop - Tomcat 10

## Yêu cầu

- JDK 17 trở lên
- Maven 3.8 trở lên
- MySQL 8 trở lên
- Tomcat 10.x (Jakarta Servlet 6; Tomcat 10.1 được khuyến nghị)

## Chuẩn bị cơ sở dữ liệu

Chạy lần lượt:

```text
database/schema.sql
database/data.sql
```

Mặc định ứng dụng kết nối MySQL bằng:

```text
host=localhost, port=3306, database=aodai_shop
user=root, password=123456
```

Có thể ghi đè bằng các biến môi trường `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`
và `DB_PASS`.

Sau khi nạp `database/data.sql`, có thể đăng nhập bằng `admin` hoặc `customer`
với mật khẩu mẫu `password`. Hãy đổi hoặc xóa các tài khoản mẫu trước khi triển khai.

## Chạy bằng Tomcat 10 embedded

Từ thư mục dự án:

```bash
mvn clean cargo:run
```

Cargo sẽ chạy Tomcat 10.x ở cổng `8080` và deploy ứng dụng tại:

```text
http://localhost:8080/shop/
```

## Chạy bằng Tomcat 10 cài riêng

Build file WAR:

```bash
mvn clean package
```

Copy `target/shop.war` vào thư mục `webapps` của Tomcat 10 rồi khởi động:

```text
<TOMCAT_HOME>\bin\startup.bat
```

Ứng dụng truy cập tại `http://localhost:8080/shop/`.
