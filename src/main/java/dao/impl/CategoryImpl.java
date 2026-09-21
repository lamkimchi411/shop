package dao.impl;

import dao.CategoryDao;
import driver.MySQLDriver;
import model.Category;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * NGUYÊN LÝ HOẠT ĐỘNG VÀ VAI TRÒ:
 * `CategoryImpl` triển khai interface `CategoryDao`, chứa toàn bộ mã nguồn thực thi câu lệnh SQL JDBC 
 * để tương tác với bảng `categories` trong CSDL MySQL.
 */
public class CategoryImpl implements CategoryDao {

    /**
     * Dữ liệu giả lập phòng ngừa (Mock Data Fallback):
     * Nếu chưa tạo CSDL hoặc kết nối MySQL bị ngắt, hàm này cung cấp dữ liệu mẫu sẵn 
     * để hệ thống vẫn chạy mượt mà mà không bị sập trang web.
     */
    private List<Category> getMockCategories() {
        List<Category> list = new ArrayList<>();
        list.add(new Category(1, "Áo Giao Lĩnh", "Cổ phục Giao Lĩnh truyền thống"));
        list.add(new Category(2, "Áo Ngũ Thân", "Áo Ngũ Thân quý tộc cung đình"));
        list.add(new Category(3, "Nón", "Nón lá bọc lụa gấm thêu tay"));
        list.add(new Category(4, "Silk Scarf", "Khăn quàng lụa gấm thủ công"));
        return list;
    }

    /**
     * Thêm danh mục mới vào CSDL MySQL.
     * 
     * Nguyên lý hoạt động từng dòng:
     * Dòng 1: Tạo câu lệnh SQL INSERT với dấu chấm hỏi `?` (PreparedStatement) để chống tấn công SQL Injection.
     * Dòng 2: Lấy Connection từ `MySQLDriver.getInstance().getConnection()`.
     * Dòng 3: Tạo PreparedStatement truyền tham số `name` và `description`.
     * Dòng 4: Gọi `stmt.executeUpdate()` thực thi SQL. Trả về true nếu số dòng bị ảnh hưởng > 0.
     */
    @Override
    public boolean insert(Category category) {
        String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
        try (Connection con = MySQLDriver.getInstance().getConnection()) { // Lấy kết nối MySQL
            if (con == null) return false; // Nếu không thể mở kết nối CSDL, dừng lại
            try (PreparedStatement stmt = con.prepareStatement(sql)) { // Chuẩn bị câu lệnh SQL
                stmt.setString(1, category.getName());       // Gán giá trị tên danh mục vào dấu ? thứ 1
                stmt.setString(2, category.getDescription());// Gán giá trị mô tả vào dấu ? thứ 2
                return stmt.executeUpdate() > 0;              // Thực thi SQL và trả về kết quả thành công/thất bại
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi nếu có vấn đề về cú pháp SQL hoặc ràng buộc CSDL
        }
        return false;
    }

    /**
     * Cập nhật thông tin danh mục theo ID.
     */
    @Override
    public boolean update(Category category) {
        String sql = "UPDATE categories SET name = ?, description = ? WHERE id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return false;
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, category.getName());       // Gán tên mới
                stmt.setString(2, category.getDescription());// Gán mô tả mới
                stmt.setInt(3, category.getId());             // Gán ID danh mục cần cập nhật
                return stmt.executeUpdate() > 0;              // Thực thi cập nhật
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa danh mục theo ID.
     */
    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM categories WHERE id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return false;
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, id);             // Gán ID danh mục cần xóa
                return stmt.executeUpdate() > 0; // Thực thi lệnh xóa
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Tìm danh mục theo ID.
     */
    @Override
    public Category find(int id) {
        String sql = "SELECT * FROM categories WHERE id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    try (ResultSet rs = stmt.executeQuery()) { // Thực thi câu lệnh truy vấn SELECT
                        if (rs.next()) { // Nếu tìm thấy bản ghi tương ứng
                            return new Category(
                                    rs.getInt("id"),          // Đọc cột id
                                    rs.getString("name"),        // Đọc cột name
                                    rs.getString("description") // Đọc cột description
                            );
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Fallback: Tìm trong danh sách dữ liệu mẫu nếu MySQL không trả về dữ liệu
        for (Category c : getMockCategories()) {
            if (c.getId() == id) return c;
        }
        return null;
    }

    /**
     * Lấy toàn bộ danh sách danh mục để hiển thị lên Menu/Navigation của website.
     */
    @Override
    public List<Category> findAll() {
        List<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM categories ORDER BY id ASC";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) { // Duyệt qua từng bản ghi trả về trong CSDL
                        categoryList.add(new Category(
                                rs.getInt("id"),
                                rs.getString("name"),
                                rs.getString("description")
                        ));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Trả về danh sách lấy từ MySQL, nếu rỗng thì dùng danh sách dữ liệu giả lập (Mock)
        return categoryList.isEmpty() ? getMockCategories() : categoryList;
    }
}
