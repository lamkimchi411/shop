package controller.customer;

import controller.BaseServlet;
import dao.DatabaseDao;
import dao.OrderDao;
import dao.ProductDao;
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
import model.Product;

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
        Product directProduct = findDirectProduct(request);

        if (directProduct == null && (cart == null || cart.isEmpty())) {
            session.setAttribute("errorMsg", "Không thể thanh toán vì giỏ hàng đang trống.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        if (directProduct != null) {
            int quantity = getQuantity(request);
            request.setAttribute("directProduct", directProduct);
            request.setAttribute("directQuantity", quantity);
            request.setAttribute("directTotal", directProduct.getPrice() * quantity);
        }
        request.getRequestDispatcher("/views/customer/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user == null) {
            request.getSession(true).setAttribute("errorMsg", "Không thể đặt hàng vì bạn chưa đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        Product directProduct = findDirectProduct(request);

        if (directProduct == null && (cart == null || cart.isEmpty())) {
            session.setAttribute("errorMsg", "Không thể đặt hàng vì giỏ hàng đang trống.");
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

        int directQuantity = getQuantity(request);
        double totalMoney = directProduct != null ? directProduct.getPrice() * directQuantity : cart.getTotalMoney();
        List<OrderDetail> details = new ArrayList<>();

        if (directProduct != null) {
            details.add(new OrderDetail(directProduct.getId(), directProduct.getPrice(), directQuantity));
        } else {
            for (CartItem item : cart.getItems()) {
                details.add(new OrderDetail(
                        item.getProduct().getId(),
                        item.getProduct().getPrice(),
                        item.getQuantity()
                ));
            }
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
            if (directProduct == null) {
                cart.clear();
                session.removeAttribute("cartTotal");
                session.removeAttribute("cartCount");
            }
            session.setAttribute("successMsg", "Đặt hàng thành công! Đơn hàng của bạn đang được xử lý.");
            response.sendRedirect(request.getContextPath() + "/orders");
        } else {
            request.setAttribute("error", "Đặt hàng thất bại. Vui lòng kiểm tra lại số lượng tồn kho!");
            request.getRequestDispatcher("/views/customer/checkout.jsp").forward(request, response);
        }
    }

    private Product findDirectProduct(HttpServletRequest request) {
        String productId = request.getParameter("productId");
        if (productId == null || productId.trim().isEmpty()) return null;
        try {
            return DatabaseDao.getInstance().getProductDao().find(Integer.parseInt(productId));
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private int getQuantity(HttpServletRequest request) {
        try {
            return Math.max(1, Integer.parseInt(request.getParameter("quantity")));
        } catch (Exception e) {
            return 1;
        }
    }
}
