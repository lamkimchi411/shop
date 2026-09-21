package dao.impl;

import dao.OrderDao;
import driver.MySQLDriver;
import model.Order;
import model.OrderDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderImpl implements OrderDao {

    private List<Order> getMockOrders() {
        List<Order> list = new ArrayList<>();
        Order o1 = new Order(1, 2, new Timestamp(System.currentTimeMillis() - 86400000L), 6300000.0, "COMPLETED", "72 Lê Lợi, Quận 1, TP. Hồ Chí Minh");
        o1.setUserName("Nguyễn Văn Hùng");
        o1.setPhone("0903123456");
        o1.getDetails().add(new OrderDetail(1, 1, 1, 1, 3500000.0, "Áo Giao Lĩnh Hoàng Thân", "https://images.unsplash.com/photo-1617627143750-d86bc21e42bb?w=600"));
        o1.getDetails().add(new OrderDetail(2, 1, 2, 1, 2800000.0, "Áo Giao Lĩnh Nữ Lụa Tơ Tằm", "https://images.unsplash.com/photo-1583391733956-6c78276477e2?w=600"));

        Order o2 = new Order(2, 3, new Timestamp(System.currentTimeMillis() - 3600000L * 5), 4200000.0, "PENDING", "15 Tràng Tiền, Hoàn Kiếm, Hà Nội");
        o2.setUserName("Trần Thị Mai");
        o2.setPhone("0912987654");
        o2.getDetails().add(new OrderDetail(3, 2, 3, 1, 4200000.0, "Áo Ngũ Thân Tay Chẽn Nam", "https://images.unsplash.com/photo-1509631179647-0177331693ae?w=600"));

        list.add(o1);
        list.add(o2);
        return list;
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setTotalMoney(rs.getDouble("total_money"));
        order.setStatus(rs.getString("status"));
        order.setShippingAddress(rs.getString("shipping_address"));
        try {
            order.setUserName(rs.getString("user_name"));
            order.setPhone(rs.getString("phone"));
        } catch (SQLException ignored) {
        }
        return order;
    }

    @Override
    public int insert(Order order) {
        String sqlOrder = "INSERT INTO orders (user_id, total_money, status, shipping_address) VALUES (?, ?, ?, ?)";
        String sqlDetail = "INSERT INTO order_details (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return -1;
            con.setAutoCommit(false);
            try (PreparedStatement psOrder = con.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, order.getUserId());
                psOrder.setDouble(2, order.getTotalMoney());
                psOrder.setString(3, order.getStatus() != null ? order.getStatus() : "PENDING");
                psOrder.setString(4, order.getShippingAddress());
                int affected = psOrder.executeUpdate();
                if (affected > 0) {
                    try (ResultSet rs = psOrder.getGeneratedKeys()) {
                        if (rs.next()) {
                            int orderId = rs.getInt(1);
                            order.setId(orderId);
                            if (order.getDetails() != null && !order.getDetails().isEmpty()) {
                                try (PreparedStatement psDetail = con.prepareStatement(sqlDetail)) {
                                    for (OrderDetail detail : order.getDetails()) {
                                        psDetail.setInt(1, orderId);
                                        psDetail.setInt(2, detail.getProductId());
                                        psDetail.setInt(3, detail.getQuantity());
                                        psDetail.setDouble(4, detail.getPrice());
                                        psDetail.addBatch();
                                    }
                                    psDetail.executeBatch();
                                }
                            }
                            con.commit();
                            return orderId;
                        }
                    }
                }
            } catch (SQLException e) {
                con.rollback();
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public boolean update(Order order) {
        String sql = "UPDATE orders SET status = ?, shipping_address = ? WHERE id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return false;
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, order.getStatus());
                stmt.setString(2, order.getShippingAddress());
                stmt.setInt(3, order.getId());
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con == null) return false;
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, status);
                stmt.setInt(2, orderId);
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM orders WHERE id = ?";
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
    public Order find(int id) {
        String sql = "SELECT o.*, u.fullname AS user_name, u.phone AS phone FROM orders o LEFT JOIN users u ON o.user_id = u.id WHERE o.id = ?";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            Order o = mapOrder(rs);
                            o.setDetails(findOrderDetails(o.getId(), con));
                            return o;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        for (Order o : getMockOrders()) {
            if (o.getId() == id) return o;
        }
        return null;
    }

    @Override
    public List<Order> findAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.fullname AS user_name, u.phone AS phone FROM orders o LEFT JOIN users u ON o.user_id = u.id ORDER BY o.id DESC";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Order o = mapOrder(rs);
                        list.add(o);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list.isEmpty() ? getMockOrders() : list;
    }

    @Override
    public List<Order> findByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.fullname AS user_name, u.phone AS phone FROM orders o LEFT JOIN users u ON o.user_id = u.id WHERE o.user_id = ? ORDER BY o.id DESC";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql)) {
                    stmt.setInt(1, userId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            Order o = mapOrder(rs);
                            o.setDetails(findOrderDetails(o.getId(), con));
                            list.add(o);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (list.isEmpty()) {
            for (Order o : getMockOrders()) {
                if (o.getUserId() == userId) list.add(o);
            }
        }
        return list;
    }

    @Override
    public int countOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getMockOrders().size();
    }

    @Override
    public double sumTotalRevenue() {
        String sql = "SELECT SUM(total_money) FROM orders WHERE status = 'COMPLETED'";
        try (Connection con = MySQLDriver.getInstance().getConnection()) {
            if (con != null) {
                try (PreparedStatement stmt = con.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) return rs.getDouble(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        double sum = 0;
        for (Order o : getMockOrders()) {
            if ("COMPLETED".equalsIgnoreCase(o.getStatus())) sum += o.getTotalMoney();
        }
        return sum;
    }

    private List<OrderDetail> findOrderDetails(int orderId, Connection con) {
        List<OrderDetail> details = new ArrayList<>();
        String sql = "SELECT d.*, p.name AS product_name, p.image AS product_image FROM order_details d LEFT JOIN products p ON d.product_id = p.id WHERE d.order_id = ?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderDetail od = new OrderDetail();
                    od.setId(rs.getInt("id"));
                    od.setOrderId(rs.getInt("order_id"));
                    od.setProductId(rs.getInt("product_id"));
                    od.setQuantity(rs.getInt("quantity"));
                    od.setPrice(rs.getDouble("price"));
                    od.setProductName(rs.getString("product_name"));
                    od.setProductImage(rs.getString("product_image"));
                    details.add(od);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }
}
