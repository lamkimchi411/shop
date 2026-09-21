-- Dữ liệu khởi tạo (Sample Data) cho Website Trang Phục Truyền Thống Việt Nam
USE `aodai_shop`;

-- 1. Insert Categories
INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'Áo Dài Nữ', 'Các mẫu Áo Dài truyền thống và cách tân dành cho phái đẹp, tôn vinh nét đẹp dịu dàng Việt Nam.'),
(2, 'Áo Dài Nam', 'Áo Dài Nam truyền thống, áo ngũ thân tay chẽn, mang phong thái uy nghi, sang trọng.'),
(3, 'Cổ Phục Việt Nam', 'Các dòng Cổ phục phục dựng chuẩn lịch sử: Áo Nhật Bình, Áo Ngũ Thân Lập Lĩnh, Áo Giao Lĩnh.'),
(4, 'Áo Tứ Thân & Áo Bà Ba', 'Trang phục truyền thống miền Bắc và miền Tây Nam Bộ, mộc mạc và giàu bản sắc văn hóa.');

-- 2. Insert Users
-- Mật khẩu của hai tài khoản mẫu là: password
-- Giá trị BCrypt dưới đây là hash hợp lệ của mật khẩu trên.
INSERT INTO `users` (`id`, `username`, `password`, `fullname`, `email`, `phone`, `address`, `role`) VALUES
(1, 'admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Quản Trị Viên', 'admin@aodaiviet.vn', '0901234567', '79 Hoàng Hoa Thám, Ba Đình, Hà Nội', 'ADMIN'),
(2, 'customer', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Nguyễn Thị Hoa', 'hoanguyen@gmail.com', '0987654321', '123 Nguyễn Huệ, Quận 1, TP. Hồ Chí Minh', 'CUSTOMER');

-- 3. Insert Products
INSERT INTO `products` (`id`, `name`, `price`, `quantity`, `image`, `description`, `category_id`) VALUES
(1, 'Áo Dài Lụa Tơ Tằm Thêu Hoa Sen', 2500000, 15, 'static/images/aodai-sen.jpg', 'Áo dài nữ chất liệu lụa tơ tằm Bảo Lộc thêu thủ công hoa sen tinh tế, mang vẻ đẹp thanh cao truyền thống.', 1),
(2, 'Áo Dài Gấm Đỏ Họa Tiết Chim Phượng', 1850000, 20, 'static/images/aodai-phuong.jpg', 'Áo dài gấm thượng hạng sắc đỏ rực rỡ, may chuẩn dáng truyền thống 4 tà mềm mại phù hợp dịp lễ tết và cưới hỏi.', 1),
(3, 'Áo Ngũ Thân Nam Tay Chẽn Hoàng Gia', 3200000, 10, 'static/images/aonguthan-nam.jpg', 'Cổ phục Áo Ngũ Thân nam chất liệu gấm tơ tằm, đường khâu thủ công tinh xảo, thể hiện nét khí phách nam nhi Việt.', 2),
(4, 'Áo Nhật Bình Triều Nguyễn (Sắc Tím Cung Đình)', 4500000, 8, 'static/images/nhatbinh-tim.jpg', 'Cổ phục Áo Nhật Bình may chuẩn phom dáng thời Nguyễn, hoa văn may thêu dải cổ tay và ngực áo vô cùng lộng lẫy.', 3),
(5, 'Áo Tứ Thân Kinh Bắc Kèm Yếm Thắm', 1650000, 12, 'static/images/tuthan-kinhbac.jpg', 'Bộ Áo Tứ Thân truyền thống xứ Kinh Bắc gồm áo khoác ngoài, áo yếm lụa đỏ, nón lá chao và khăn mỏ quạ.', 4),
(6, 'Áo Bà Ba Nam Bộ Lụa Nam Tuyền', 850000, 25, 'static/images/baba-nambo.jpg', 'Bộ áo bà ba chất liệu lụa Nam Tuyền mềm mát, kèm khăn truyền thống đậm đà bản sắc Nam Bộ.', 4),
(7, 'Áo Giao Lĩnh Cổ Phục Việt Nam', 2900000, 9, 'static/images/giaolinh.jpg', 'Cổ phục Áo Giao Lĩnh cổ chéo kết hợp dải xiêm thắt lưng, chất liệu lụa cao cấp tự nhiên.', 3),
(8, 'Áo Dài Nam Trắng Thêu Rồng', 2200000, 14, 'static/images/aodai-rong.jpg', 'Áo dài nam phong cách tân cổ điển, gam màu trắng thanh lịch thêu họa tiết Rồng mây khí chất.', 2);

-- 4. Insert Sample Orders & Order Details
INSERT INTO `orders` (`id`, `user_id`, `order_date`, `total_money`, `status`, `shipping_address`) VALUES
(1, 2, '2026-09-10 10:30:00', 4350000, 'COMPLETED', '123 Nguyễn Huệ, Quận 1, TP. Hồ Chí Minh'),
(2, 2, '2026-09-14 14:15:00', 2500000, 'PROCESSING', '123 Nguyễn Huệ, Quận 1, TP. Hồ Chí Minh');

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `price`, `quantity`) VALUES
(1, 1, 1, 2500000, 1),
(2, 1, 2, 1850000, 1),
(3, 2, 1, 2500000, 1);
