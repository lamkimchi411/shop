-- Sửa các bản ghi dữ liệu mẫu đã được import sai mã hóa trước đây.
-- Script này KHÔNG xóa bảng hoặc dữ liệu do người dùng tự tạo.
SET NAMES utf8mb4;
USE `aodai_shop`;

UPDATE `categories`
SET
    `name` = CASE `id`
        WHEN 1 THEN 'Áo Dài Nữ'
        WHEN 2 THEN 'Áo Dài Nam'
        WHEN 3 THEN 'Cổ Phục Việt Nam'
        WHEN 4 THEN 'Áo Tứ Thân & Áo Bà Ba'
    END,
    `description` = CASE `id`
        WHEN 1 THEN 'Các mẫu Áo Dài truyền thống và cách tân dành cho phái đẹp, tôn vinh nét đẹp dịu dàng Việt Nam.'
        WHEN 2 THEN 'Áo Dài Nam truyền thống, áo ngũ thân tay chẽn, mang phong thái uy nghi, sang trọng.'
        WHEN 3 THEN 'Các dòng Cổ phục phục dựng chuẩn lịch sử: Áo Nhật Bình, Áo Ngũ Thân Lập Lĩnh, Áo Giao Lĩnh.'
        WHEN 4 THEN 'Trang phục truyền thống miền Bắc và miền Tây Nam Bộ, mộc mạc và giàu bản sắc văn hóa.'
    END
WHERE `id` IN (1, 2, 3, 4);

UPDATE `products`
SET
    `name` = CASE `id`
        WHEN 1 THEN 'Áo Dài Lụa Tơ Tằm Thêu Hoa Sen'
        WHEN 2 THEN 'Áo Dài Gấm Đỏ Họa Tiết Chim Phượng'
        WHEN 3 THEN 'Áo Ngũ Thân Nam Tay Chẽn Hoàng Gia'
        WHEN 4 THEN 'Áo Nhật Bình Triều Nguyễn (Sắc Tím Cung Đình)'
        WHEN 5 THEN 'Áo Tứ Thân Kinh Bắc Kèm Yếm Thắm'
        WHEN 6 THEN 'Áo Bà Ba Nam Bộ Lụa Nam Tuyền'
        WHEN 7 THEN 'Áo Giao Lĩnh Cổ Phục Việt Nam'
        WHEN 8 THEN 'Áo Dài Nam Trắng Thêu Rồng'
    END,
    `description` = CASE `id`
        WHEN 1 THEN 'Áo dài nữ chất liệu lụa tơ tằm Bảo Lộc thêu thủ công hoa sen tinh tế, mang vẻ đẹp thanh cao truyền thống.'
        WHEN 2 THEN 'Áo dài gấm thượng hạng sắc đỏ rực rỡ, may chuẩn dáng truyền thống 4 tà mềm mại phù hợp dịp lễ tết và cưới hỏi.'
        WHEN 3 THEN 'Cổ phục Áo Ngũ Thân nam chất liệu gấm tơ tằm, đường khâu thủ công tinh xảo, thể hiện nét khí phách nam nhi Việt.'
        WHEN 4 THEN 'Cổ phục Áo Nhật Bình may chuẩn phom dáng thời Nguyễn, hoa văn may thêu dải cổ tay và ngực áo vô cùng lộng lẫy.'
        WHEN 5 THEN 'Bộ Áo Tứ Thân truyền thống xứ Kinh Bắc gồm áo khoác ngoài, áo yếm lụa đỏ, nón lá chao và khăn mỏ quạ.'
        WHEN 6 THEN 'Bộ áo bà ba chất liệu lụa Nam Tuyền mềm mát, kèm khăn truyền thống đậm đà bản sắc Nam Bộ.'
        WHEN 7 THEN 'Áo Giao Lĩnh cổ phục cổ chéo kết hợp dải xiêm thắt lưng, chất liệu lụa cao cấp tự nhiên.'
        WHEN 8 THEN 'Áo dài nam phong cách tân cổ điển, gam màu trắng thanh lịch thêu họa tiết Rồng mây khí chất.'
    END
WHERE `id` IN (1, 2, 3, 4, 5, 6, 7, 8);

UPDATE `users`
SET
    `fullname` = CASE `username`
        WHEN 'admin' THEN 'Quản Trị Viên'
        WHEN 'customer' THEN 'Nguyễn Thị Hoa'
    END,
    `address` = CASE `username`
        WHEN 'admin' THEN '79 Hoàng Hoa Thám, Ba Đình, Hà Nội'
        WHEN 'customer' THEN '123 Nguyễn Huệ, Quận 1, TP. Hồ Chí Minh'
    END
WHERE `username` IN ('admin', 'customer');

UPDATE `orders`
SET `shipping_address` = '123 Nguyễn Huệ, Quận 1, TP. Hồ Chí Minh'
WHERE `id` IN (1, 2) AND `user_id` = 2;
