package controller.admin;

import dao.DatabaseDao;
import dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;

import java.io.IOException;
import java.util.List;

/**
 * Controller: Quản Lý & Duyệt Đơn Hàng (Admin)
 */
@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/orders"})
public class AdminOrderServlet extends BaseAdminServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();
        String id = request.getParameter("id");
        if (id != null) {
            try {
                Order selectedOrder = orderDao.find(Integer.parseInt(id));
                if (selectedOrder != null) {
                    request.setAttribute("selectedOrder", selectedOrder);
                } else {
                    request.getSession().setAttribute("errorMsg", "Không tìm thấy đơn hàng.");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMsg", "Mã đơn hàng không hợp lệ.");
            }
        }
        List<Order> orders = orderDao.findAll();
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/views/admin/order-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();
        String orderIdStr = request.getParameter("id");
        String status = request.getParameter("status");

        if (orderIdStr != null && status != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                if (!status.matches("PENDING|PROCESSING|SHIPPED|COMPLETED|CANCELLED")) {
                    throw new IllegalArgumentException("Trạng thái đơn hàng không hợp lệ.");
                }
                boolean updated = orderDao.updateStatus(orderId, status);
                if (updated) {
                    request.getSession().setAttribute("successMsg", "Cập nhật trạng thái đơn hàng #" + orderId + " thành công!");
                } else {
                    request.getSession().setAttribute("errorMsg", "Cập nhật trạng thái đơn hàng thất bại!");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMsg", "Mã đơn hàng không hợp lệ!");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
