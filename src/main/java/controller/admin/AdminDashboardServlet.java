package controller.admin;

import dao.DatabaseDao;
import dao.OrderDao;
import dao.ProductDao;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.Product;

import java.io.IOException;
import java.util.List;

/**
 * Controller: Admin Dashboard Tổng Quan Thống Kê
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = { "/admin/dashboard" })
public class AdminDashboardServlet extends BaseAdminServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDao productDao = DatabaseDao.getInstance().getProductDao();
        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();
        UserDao userDao = DatabaseDao.getInstance().getUserDao();

        List<Product> allProducts = productDao.findAll();
        List<Order> recentOrders = orderDao.findAll();

        double totalRevenue = orderDao.sumTotalRevenue();
        int totalOrders = orderDao.countOrders();
        int totalProducts = allProducts.size();
        int totalUsers = userDao.findAll().size();

        long lowStockCount = allProducts.stream().filter(p -> p.getQuantity() <= 10).count();

        if (recentOrders.size() > 5) {
            recentOrders = recentOrders.subList(0, 5);
        }

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("lowStockCount", lowStockCount);
        request.setAttribute("recentOrders", recentOrders);

        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }
}
