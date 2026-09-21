-- ====================================================================
-- SCRIPT KHỞI TẠO CƠ SỞ DỮ LIỆU CHO MYSQL WORKBENCH
-- Dự án: Website Bán & Quản Lý Trang Phục Truyền Thống Việt Nam
-- ====================================================================

-- Bắt buộc phiên làm việc dùng UTF-8 để không làm hỏng tiếng Việt khi import.
SET NAMES utf8mb4;

-- 1. TẠO CƠ SỞ DỮ LIỆU
CREATE DATABASE IF NOT EXISTS `aodai_shop` 
DEFAULT CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `aodai_shop`;

-- 2. XÓA BẢNG CŨ NẾU TỒN TẠI (Theo thứ tự ràng buộc khóa ngoại)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `order_details`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `categories`;
DROP TABLE IF EXISTS `users`;
SET FOREIGN_KEY_CHECKS = 1;

-- 3. TẠO CÁC BẢNG (TABLES)

-- Bảng 1: users (Người dùng & Phân quyền)
CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL, -- Mật khẩu được mã hóa băm BCrypt
    `fullname` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(20),
    `address` TEXT,
    `role` VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER', -- 'CUSTOMER' hoặc 'ADMIN'
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng 2: categories (Danh mục sản phẩm)
CREATE TABLE `categories` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng 3: products (Trang phục truyền thống)
CREATE TABLE `products` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(150) NOT NULL,
    `price` DOUBLE NOT NULL,
    `quantity` INT NOT NULL DEFAULT 0,
    `image` VARCHAR(255),
    `description` TEXT,
    `category_id` INT,
    CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng 4: orders (Đơn hàng)
CREATE TABLE `orders` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `order_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `total_money` DOUBLE NOT NULL,
    `status` VARCHAR(50) NOT NULL DEFAULT 'PENDING', -- 'PENDING', 'PROCESSING', 'SHIPPED', 'COMPLETED', 'CANCELLED'
    `shipping_address` TEXT NOT NULL,
    CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng 5: order_details (Chi tiết đơn hàng)
CREATE TABLE `order_details` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `price` DOUBLE NOT NULL,
    `quantity` INT NOT NULL,
    CONSTRAINT `fk_detail_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_detail_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. THÊM DỮ LIỆU MẪU (INSERT SAMPLE DATA)

-- Thêm Danh Mục
INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'Áo Dài Nữ', 'Các mẫu Áo Dài truyền thống và cách tân dành cho phái đẹp, tôn vinh nét đẹp dịu dàng Việt Nam.'),
(2, 'Áo Dài Nam', 'Áo Dài Nam truyền thống, áo ngũ thân tay chẽn, mang phong thái uy nghi, sang trọng.'),
(3, 'Cổ Phục Việt Nam', 'Các dòng Cổ phục phục dựng chuẩn lịch sử: Áo Nhật Bình, Áo Ngũ Thân Lập Lĩnh, Áo Giao Lĩnh.'),
(4, 'Áo Tứ Thân & Áo Bà Ba', 'Trang phục truyền thống miền Bắc và miền Tây Nam Bộ, mộc mạc và giàu bản sắc văn hóa.');

-- Thêm Người Dùng Mẫu
-- Mật khẩu của hai tài khoản mẫu là: password
-- Giá trị BCrypt dưới đây là hash hợp lệ của mật khẩu trên.
INSERT INTO `users` (`id`, `username`, `password`, `fullname`, `email`, `phone`, `address`, `role`) VALUES
(1, 'admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Quản Trị Viên', 'admin@aodaiviet.vn', '0901234567', '79 Hoàng Hoa Thám, Ba Đình, Hà Nội', 'ADMIN'),
(2, 'customer', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Nguyễn Thị Hoa', 'hoanguyen@gmail.com', '0987654321', '123 Nguyễn Huệ, Quận 1, TP. Hồ Chí Minh', 'CUSTOMER');

-- Thêm Sản Phẩm Áo Dài & Cổ Phục
INSERT INTO `products` (`id`, `name`, `price`, `quantity`, `image`, `description`, `category_id`) VALUES
(1, 'Áo Dài Lụa Tơ Tằm Thêu Hoa Sen', 2500000, 15, 'static/images/aodai-sen.jpg', 'Áo dài nữ chất liệu lụa tơ tằm Bảo Lộc thêu thủ công hoa sen tinh tế, mang vẻ đẹp thanh cao truyền thống.', 1),
(2, 'Áo Dài Gấm Đỏ Họa Tiết Chim Phượng', 1850000, 20, 'static/images/aodai-phuong.jpg', 'Áo dài gấm thượng hạng sắc đỏ rực rỡ, may chuẩn dáng truyền thống 4 tà mềm mại phù hợp dịp lễ tết và cưới hỏi.', 1),
(3, 'Áo Ngũ Thân Nam Tay Chẽn Hoàng Gia', 3200000, 10, 'static/images/aonguthan-nam.jpg', 'Cổ phục Áo Ngũ Thân nam chất liệu gấm tơ tằm, đường khâu thủ công tinh xảo, thể hiện nét khí phách nam nhi Việt.', 2),
(4, 'Áo Nhật Bình Triều Nguyễn (Sắc Tím Cung Đình)', 4500000, 8, 'static/images/nhatbinh-tim.jpg', 'Cổ phục Áo Nhật Bình may chuẩn phom dáng thời Nguyễn, hoa văn may thêu dải cổ tay và ngực áo vô cùng lộng lẫy.', 3),
(5, 'Áo Tứ Thân Kinh Bắc Kèm Yếm Thắm', 1650000, 12, 'static/images/tuthan-kinhbac.jpg', 'Bộ Áo Tứ Thân truyền thống xứ Kinh Bắc gồm áo khoác ngoài, áo yếm lụa đỏ, nón lá chao và khăn mỏ quạ.', 4),
(6, 'Áo Bà Ba Nam Bộ Lụa Nam Tuyền', 850000, 25, 'static/images/baba-nambo.jpg', 'Bộ áo bà ba chất liệu lụa Nam Tuyền mềm mát, kèm khăn truyền thống đậm đà bản sắc Nam Bộ.', 4),
(7, 'Áo Giao Lĩnh Cổ Phục Việt Nam', 2900000, 9, 'static/images/giaolinh.jpg', 'Cổ phục Áo Giao Lĩnh cổ chéo kết hợp dải xiêm thắt lưng, chất liệu lụa cao cấp tự nhiên.', 3),
(8, 'Áo Dài Nam Trắng Thêu Rồng', 2200000, 14, 'static/images/aodai-rong.jpg', 'Áo dài nam phong cách tân cổ điển, gam màu trắng thanh lịch thêu họa tiết Rồng mây khí chất.', 2);

-- Thêm Đơn Hàng Mẫu
INSERT INTO `orders` (`id`, `user_id`, `order_date`, `total_money`, `status`, `shipping_address`) VALUES
(1, 2, '2026-09-10 10:30:00', 4350000, 'COMPLETED', '123 Nguyễn Huệ, Quận 1, TP. Hồ Chí Minh'),
(2, 2, '2026-09-14 14:15:00', 2500000, 'PROCESSING', '123 Nguyễn Huệ, Quận 1, TP. Hồ Chí Minh');

-- Thêm Chi Tiết Đơn Hàng Mẫu
INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `price`, `quantity`) VALUES
(1, 1, 1, 2500000, 1),
(2, 1, 2, 1850000, 1),
(3, 2, 1, 2500000, 1);

-- 5. KIỂM TRA DỮ LIỆU SAU KHI TẠO
SELECT 'Bảng Users:' AS Status;
SELECT id, username, fullname, role FROM users;

SELECT 'Bảng Categories:' AS Status;
SELECT id, name FROM categories;

SELECT 'Bảng Products:' AS Status;
SELECT id, name, price, quantity FROM products;
