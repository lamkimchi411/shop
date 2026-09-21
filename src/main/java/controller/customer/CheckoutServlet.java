package controller.customer;

import controller.BaseServlet;
import dao.DatabaseDao;
import dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.CartItem;
import model.Order;
import model.OrderDetail;
import model.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Controller: Đặt Hàng & Thanh Toán (Checkout)
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        super.doGet(request, response);

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user == null) {
            request.getSession(true).setAttribute("errorMsg", "Vui lòng đăng nhập tài khoản để tiến hành đặt hàng.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        request.getRequestDispatcher("/views/customer/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        String address = request.getParameter("address");
        if (address == null || address.trim().isEmpty()) {
            address = request.getParameter("shippingAddress");
        }

        if (address == null || address.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập địa chỉ giao hàng!");
            request.getRequestDispatcher("/views/customer/checkout.jsp").forward(request, response);
            return;
        }

        double totalMoney = cart.getTotalMoney();
        List<OrderDetail> details = new ArrayList<>();

        for (CartItem item : cart.getItems()) {
            details.add(new OrderDetail(
                    item.getProduct().getId(),
                    item.getProduct().getPrice(),
                    item.getQuantity()
            ));
        }

        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotalMoney(totalMoney);
        order.setShippingAddress(address.trim());
        order.setStatus("PENDING");
        order.setDetails(details);

        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();
        int orderId = orderDao.insert(order);

        if (orderId > 0) {
            cart.clear();
            session.removeAttribute("cartTotal");
            session.removeAttribute("cartCount");
            session.setAttribute("successMsg", "Đặt hàng thành công! Đơn hàng của bạn đang được xử lý.");
            response.sendRedirect(request.getContextPath() + "/orders");
        } else {
            request.setAttribute("error", "Đặt hàng thất bại. Vui lòng kiểm tra lại số lượng tồn kho!");
            request.getRequestDispatcher("/views/customer/checkout.jsp").forward(request, response);
        }
    }
}
