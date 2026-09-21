package dao;

import model.Order;
import java.util.List;

public interface OrderDao {
    int insert(Order order);
    boolean update(Order order);
    boolean updateStatus(int orderId, String status);
    boolean delete(int id);
    Order find(int id);
    List<Order> findAll();
    List<Order> findByUser(int userId);
    int countOrders();
    double sumTotalRevenue();
}
