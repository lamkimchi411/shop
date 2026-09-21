# AGENT.MD - DỰ ÁN CỔ VIỆT LÂU (TOKEN-EFFICIENT GUIDELINES)

File này chứa thông tin tóm tắt kiến trúc, sơ đồ route, quy chuẩn giao diện và hướng dẫn tối ưu token khi làm việc với AI trong dự án này.

---

## 🚀 1. TỔNG QUAN DỰ ÁN (PROJECT STACK)
- **Công nghệ chính**: Java Web MVC (Jakarta EE / Servlet 6.0 - Tomcat 10.x).
- **Build Tool**: Apache Maven (Java 17+).
- **Cơ sở dữ liệu**: MySQL 8.0+ (`aodai_shop`, host: `localhost:3306`, user: `root`, pass: `123456`).
- **Web App Directory**: `src/main/webapp`
- **Port chạy ứng dụng**: `http://localhost:8080/shop/`
- **Lệnh đóng gói & chạy server**:
  ```bash
  mvn package cargo:run
  ```

---

## 🎨 2. DESIGN SYSTEM & QUY CHUẨN GIAO DIỆN (CỔ VIỆT LÂU)
Tất cả các trang đều sử dụng chung hệ thống CSS tại: `src/main/webapp/static/css/style.css`

### Palette Màu (CSS Variables)
- `--primary-red: #a31818;` (Đỏ huyết dụ ấn triện)
- `--gold-accent: #b89243;` (Vàng hoàng kim cổ)
- `--parchment-bg: #f5f0e6;` (Nền gấm kem mây mờ)
- `--dark-wood: #1c100e;` (Gỗ sơn mài tối - Header topbar & Footer)
- `--admin-dark-red: #730d0d;` (Thanh Admin Panel)

### Typography
- **Headings & Brand**: `Playfair Display`, `Cinzel` (Google Fonts).
- **Thân bài**: `Plus Jakarta Sans` / `Inter`.

### Layout Elements
- **Ấn triện đỏ Logo**: Class `.stamp-seal-logo`
- **Nút bấm dạng Pill**: `.btn-pill-red`, `.btn-pill-outline`, `.btn-pill-gold`
- **Khung nổi**: Class `.page-frame` bao ngoài toàn bộ trang web.

---

## 📂 3. CẤU TRÚC THƯ MỤC CHÍNH

```text
d:/JVNC/shop/
├── pom.xml
├── README.md
├── database/
│   ├── schema.sql
│   └── data.sql
└── src/
    └── main/
        ├── java/
        │   ├── config/ (DBContext.java, DataSeeder.java)
        │   ├── controller/
        │   │   ├── admin/ (AdminDashboardServlet, AdminUserServlet, AdminProductServlet, AdminCategoryServlet, AdminOrderServlet)
        │   │   ├── auth/ (LoginServlet, RegisterServlet, LogoutServlet)
        │   │   └── customer/ (HomeServlet, ProductListServlet, ProductDetailServlet, CartServlet, CheckoutServlet, OrderHistoryServlet)
        │   ├── dao/ (UserDAO, ProductDAO, CategoryDAO, OrderDAO)
        │   ├── filter/ (AdminFilter, AuthenticationFilter)
        │   └── model/ (User, Product, Category, Order, OrderItem, Cart)
        └── webapp/
            ├── static/
            │   └── css/style.css
            └── views/
                ├── admin/ (dashboard.jsp, user-list.jsp, product-list.jsp, product-form.jsp, category-list.jsp, order-list.jsp)
                ├── auth/ (login.jsp, register.jsp)
                ├── common/ (header.jsp, footer.jsp, admin-header.jsp)
                └── customer/ (index.jsp, products.jsp, detail.jsp, cart.jsp, checkout.jsp, orders.jsp)
```

---

## 🗺️ 4. SƠ ĐỒ ROUTE & CONTROLLERS (MAPPING)

| URL Pattern | Servlet Class | View JSP | Mô tả |
| :--- | :--- | :--- | :--- |
| `/home` | `HomeServlet` | `/views/customer/index.jsp` | Trang chủ di sản |
| `/products` | `ProductListServlet` | `/views/customer/products.jsp` | Bộ sưu tập & Bộ lọc danh mục |
| `/product-detail` | `ProductDetailServlet` | `/views/customer/detail.jsp` | Chi tiết sản phẩm may đo |
| `/cart` | `CartServlet` | `/views/customer/cart.jsp` | Giỏ hàng của bạn |
| `/checkout` | `CheckoutServlet` | `/views/customer/checkout.jsp` | Thanh toán đơn hàng |
| `/login` | `LoginServlet` | `/views/auth/login.jsp` | Đăng nhập thành viên |
| `/register` | `RegisterServlet` | `/views/auth/register.jsp` | Đăng ký thành viên |
| `/admin/dashboard`| `AdminDashboardServlet`| `/views/admin/dashboard.jsp` | Admin Panel & Thống kê biểu đồ |
| `/admin/users` | `AdminUserServlet` | `/views/admin/user-list.jsp` | Admin Quản lý người dùng |
| `/admin/products` | `AdminProductServlet` | `/views/admin/product-list.jsp` | Admin Quản lý sản phẩm |
| `/admin/categories`| `AdminCategoryServlet` | `/views/admin/category-list.jsp` | Admin Quản lý danh mục |
| `/admin/orders` | `AdminOrderServlet` | `/views/admin/order-list.jsp` | Admin Quản lý đơn hàng |

---

## 💡 5. HƯỚNG DẪN TIẾT KIỆM TOKEN CHO AI (FOR AI AGENTS)

Khi gọi AI thực hiện task trên repo này:
1. **Không đọc toàn bộ tập tin**: Đọc trực tiếp các file trong bảng Route trên theo phạm vi task.
2. **Reuse CSS Variables**: Khi thêm UI mới, luôn dùng lại các biến CSS trong `style.css` (`var(--primary-red)`, `var(--gold-accent)`, `.btn-pill-red`, v.v.), không viết thêm CSS trùng lặp.
3. **Giữ nguyên Servlet Filter & DBContext**: Không sửa file kết nối DB hay POM ngoại trừ khi cần thêm thư viện mới.
4. **Build & Verify gọn**:
   - Biên dịch: `mvn clean compile`
   - Đóng gói & Chạy Tomcat: `mvn package cargo:run`
