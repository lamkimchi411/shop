package controller.customer;

import controller.BaseServlet;
import dao.DatabaseDao;
import dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.User;

import java.io.IOException;
import java.util.List;

/**
 * Controller: Xem Lịch Sử Đơn Hàng Của Khách Hàng
 */
@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/orders"})
public class OrderHistoryServlet extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        super.doGet(request, response);

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();
        List<Order> orders = orderDao.findByUser(user.getId());
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/views/customer/orders.jsp").forward(request, response);
    }
}
