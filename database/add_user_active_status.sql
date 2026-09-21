-- Bổ sung trạng thái khóa/mở khóa tài khoản cho database đã tồn tại.
SET NAMES utf8mb4;
USE `aodai_shop`;

-- Dùng SQL động để tương thích cả MySQL 5.7 và MySQL 8.
SET @has_is_active := (
    SELECT COUNT(*)
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'users' AND COLUMN_NAME = 'is_active'
);
SET @migration_sql := IF(
    @has_is_active = 0,
    'ALTER TABLE `users` ADD COLUMN `is_active` BOOLEAN NOT NULL DEFAULT TRUE AFTER `role`',
    'SELECT 1'
);
PREPARE migration_statement FROM @migration_sql;
EXECUTE migration_statement;
DEALLOCATE PREPARE migration_statement;
