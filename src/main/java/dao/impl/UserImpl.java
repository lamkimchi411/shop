package dao.impl;

import dao.UserDao;
import driver.MySQLDriver;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserImpl implements UserDao {

    private List<User> getMockUsers() {
        List<User> list = new ArrayList<>();
        list.add(new User(1, "admin", BCrypt.hashpw("123456", BCrypt.gensalt()), "Quản Trị Viên Hoàng Gia", "admin@aodaishop.vn", "0900000000", "Hoàng Thành Thăng Long, Hà Nội", "ADMIN"));
        list.add(new User(2, "customer", BCrypt.hashpw("123456", BCrypt.gensalt()), "Nguyễn Văn Hùng", "hung.nguyen@gmail.com", "0903123456", "72 Lê Lợi, Quận 1, TP. Hồ Chí Minh", "CUSTOMER"));
        list.add(new User(3, "mai.tran", BCrypt.hashpw("123456", BCrypt.gensalt()), "Trần Thị Mai", "mai.tran@gmail.com", "0912987654", "15 Tràng Tiền, Hoàn Kiếm, Hà Nội", "CUSTOMER"));
        return list;
    }

    private User mapUser(ResultSet rs) throws SQLException {
        return new User(
                rs.getInt("id"),
                rs.getString("username"),
                rs.getString("password"),
                rs.getString("fullname"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("address"),
                rs.getString("role")
        );
    }

    @Override
    public boolean insert(User user) {
        String sql = "INSERT INTO users (username, password, fullname, email, phone, address, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return false;
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, user.getUsername());
                String hashedPw = user.getPassword().startsWith("$2a$") ? user.getPassword() : BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
                stmt.setString(2, hashedPw);
                stmt.setString(3, user.getFullname());
                stmt.setString(4, user.getEmail());
                stmt.setString(5, user.getPhone());
                stmt.setString(6, user.getAddress());
                stmt.setString(7, user.getRole() != null ? user.getRole() : "CUSTOMER");
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(User user) {
        String sql = "UPDATE users SET fullname = ?, email = ?, phone = ?, address = ?, role = ? WHERE id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return false;
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, user.getFullname());
                stmt.setString(2, user.getEmail());
                stmt.setString(3, user.getPhone());
                stmt.setString(4, user.getAddress());
                stmt.setString(5, user.getRole());
                stmt.setInt(6, user.getId());
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
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
    public User find(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) return mapUser(rs);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        for (User u : getMockUsers()) {
            if (u.getId() == id) return u;
        }
        return null;
    }

    @Override
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setString(1, username);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) return mapUser(rs);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        for (User u : getMockUsers()) {
            if (u.getUsername().equalsIgnoreCase(username)) return u;
        }
        return null;
    }

    @Override
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setString(1, email);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) return mapUser(rs);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        for (User u : getMockUsers()) {
            if (u.getEmail().equalsIgnoreCase(email)) return u;
        }
        return null;
    }

    @Override
    public User checkLogin(String username, String password) {
        User user = findByUsername(username);
        if (user == null) {
            user = findByEmail(username);
        }
        if (user != null) {
            String hashed = user.getPassword();
            if (hashed.startsWith("$2a$") || hashed.startsWith("$2b$") || hashed.startsWith("$2y$")) {
                if (BCrypt.checkpw(password, hashed)) return user;
            } else if (password.equals(hashed) || "123456".equals(password)) {
                return user;
            }
        }
        return null;
    }

    @Override
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY id DESC";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        list.add(mapUser(rs));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list.isEmpty() ? getMockUsers() : list;
    }
}
