package dao.impl;

import dao.ProductDao;
import driver.MySQLDriver;
import model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductImpl implements ProductDao {

    private List<Product> getMockProducts() {
        List<Product> list = new ArrayList<>();
        list.add(new Product(1, "Áo Giao Lĩnh Hoàng Thân", 3500000, 10, "https://images.unsplash.com/photo-1617627143750-d86bc21e42bb?w=600", "Áo Giao Lĩnh may bằng gấm thượng hạng thêu họa tiết rồng mây cung đình.", 1));
        list.add(new Product(2, "Áo Giao Lĩnh Nữ Lụa Tơ Tằm", 2800000, 15, "https://images.unsplash.com/photo-1583391733956-6c78276477e2?w=600", "Áo Giao Lĩnh nữ chất liệu lụa tơ tằm Bảo Lộc nhẹ nhàng mềm mại.", 1));
        list.add(new Product(3, "Áo Ngũ Thân Tay Chẽn Nam", 4200000, 8, "https://images.unsplash.com/photo-1509631179647-0177331693ae?w=600", "Trang phục Ngũ Thân quý phái dành cho quý ông tham dự lễ hội truyền thống.", 2));
        list.add(new Product(4, "Áo Ngũ Thân Tay Thụa Nữ Gấm", 3900000, 12, "https://images.unsplash.com/photo-1518895949257-7621c3c786d7?w=600", "Áo Ngũ Thân quý tộc thêu hoa sen tinh xảo.", 2));
        list.add(new Product(5, "Nón Lá Bọc Lụa Thêu Tay", 850000, 25, "https://images.unsplash.com/photo-1534447677768-be436bb09401?w=600", "Nón lá truyền thống bọc lụa thêu hoa sen thủ công Huế.", 3));
        list.add(new Product(6, "Khăn Quàng Lụa Gấm Hà Đông", 1200000, 30, "https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=600", "Khăn lụa gấm thêu tay tinh tế mang phong cách hoàng gia.", 4));
        return list;
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setPrice(rs.getDouble("price"));
        p.setQuantity(rs.getInt("quantity"));
        p.setImage(rs.getString("image"));
        p.setDescription(rs.getString("description"));
        p.setCategoryId(rs.getInt("category_id"));
        try {
            p.setCategoryName(rs.getString("category_name"));
        } catch (SQLException ignored) {
        }
        return p;
    }

    @Override
    public boolean insert(Product product) {
        String sql = "INSERT INTO products (name, price, quantity, image, description, category_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return false;
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, product.getName());
                stmt.setDouble(2, product.getPrice());
                stmt.setInt(3, product.getQuantity());
                stmt.setString(4, product.getImage());
                stmt.setString(5, product.getDescription());
                stmt.setInt(6, product.getCategoryId());
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Product product) {
        String sql = "UPDATE products SET name = ?, price = ?, quantity = ?, image = ?, description = ?, category_id = ? WHERE id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return false;
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, product.getName());
                stmt.setDouble(2, product.getPrice());
                stmt.setInt(3, product.getQuantity());
                stmt.setString(4, product.getImage());
                stmt.setString(5, product.getDescription());
                stmt.setInt(6, product.getCategoryId());
                stmt.setInt(7, product.getId());
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return false;
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, id);
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Product find(int id) {
        String sql = "SELECT p.*, c.name AS category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id WHERE p.id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            return mapProduct(rs);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        for (Product p : getMockProducts()) {
            if (p.getId() == id) return p;
        }
        return null;
    }

    @Override
    public List<Product> findAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name AS category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id ORDER BY p.id DESC";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        list.add(mapProduct(rs));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list.isEmpty() ? getMockProducts() : list;
    }

    @Override
    public List<Product> news(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name AS category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id ORDER BY p.id DESC LIMIT ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setInt(1, limit);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            list.add(mapProduct(rs));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (list.isEmpty()) {
            List<Product> mocks = getMockProducts();
            return mocks.subList(0, Math.min(limit, mocks.size()));
        }
        return list;
    }

    @Override
    public List<Product> featured(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name AS category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id ORDER BY p.price DESC LIMIT ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setInt(1, limit);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            list.add(mapProduct(rs));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (list.isEmpty()) {
            List<Product> mocks = getMockProducts();
            return mocks.subList(0, Math.min(limit, mocks.size()));
        }
        return list;
    }

    @Override
    public List<Product> findByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name AS category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id WHERE p.category_id = ? ORDER BY p.id DESC";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setInt(1, categoryId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            list.add(mapProduct(rs));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (list.isEmpty()) {
            for (Product p : getMockProducts()) {
                if (p.getCategoryId() == categoryId) list.add(p);
            }
        }
        return list;
    }

    @Override
    public List<Product> searchByName(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name AS category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id WHERE LOWER(p.name) LIKE ? ORDER BY p.id DESC";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setString(1, "%" + (keyword != null ? keyword.toLowerCase() : "") + "%");
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            list.add(mapProduct(rs));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (list.isEmpty() && keyword != null && !keyword.trim().isEmpty()) {
            String kw = keyword.toLowerCase();
            for (Product p : getMockProducts()) {
                if (p.getName().toLowerCase().contains(kw)) list.add(p);
            }
        }
        return list;
    }
}
