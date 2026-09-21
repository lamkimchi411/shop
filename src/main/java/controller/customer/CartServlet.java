package controller.customer;

import controller.BaseServlet;
import dao.DatabaseDao;
import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.Product;

import java.io.IOException;

/**
 * Controller: Quản Lý Giỏ Hàng (Cart) - Kế thừa BaseServlet
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        super.doGet(request, response);

        String action = request.getParameter("action");
        if (action != null) {
            handleCartAction(request, response, action);
            return;
        }

        request.getRequestDispatcher("/views/customer/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            handleCartAction(request, response, action);
        } else {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    private void handleCartAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws IOException {

        HttpSession session = request.getSession(true);
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        ProductDao productDao = DatabaseDao.getInstance().getProductDao();

        try {
            int productId = parseProductId(request);

            switch (action.toLowerCase()) {
                case "add": {
                    int quantity = 1;
                    String qParam = request.getParameter("quantity");
                    if (qParam != null && !qParam.trim().isEmpty()) {
                        quantity = Math.max(1, Integer.parseInt(qParam.trim()));
                    }

                    if (productId > 0) {
                        Product product = productDao.find(productId);
                        if (product != null) {
                            cart.addItem(product, quantity);
                            session.setAttribute("successMsg", "Đã thêm '" + product.getName() + "' vào giỏ hàng thành công!");
                        } else {
                            session.setAttribute("errorMsg", "Không thể thêm vào giỏ vì sản phẩm không tồn tại hoặc đã bị xóa.");
                        }
                    } else {
                        session.setAttribute("errorMsg", "Không thể thêm vào giỏ vì mã sản phẩm không hợp lệ.");
                    }
                    break;
                }
                case "update": {
                    String qParam = request.getParameter("quantity");
                    if (productId > 0 && qParam != null) {
                        int quantity = Integer.parseInt(qParam.trim());
                        cart.updateItem(productId, quantity);
                        session.setAttribute("successMsg", quantity > 0 ? "Đã cập nhật số lượng sản phẩm trong giỏ." : "Đã xóa sản phẩm có số lượng bằng 0 khỏi giỏ.");
                    } else {
                        session.setAttribute("errorMsg", "Không thể cập nhật giỏ hàng vì thiếu mã sản phẩm hoặc số lượng.");
                    }
                    break;
                }
                case "delete":
                case "remove": {
                    if (productId > 0) {
                        cart.removeItem(productId);
                        session.setAttribute("successMsg", "Đã xóa sản phẩm khỏi giỏ hàng!");
                    } else {
                        session.setAttribute("errorMsg", "Không thể xóa sản phẩm vì mã sản phẩm không hợp lệ.");
                    }
                    break;
                }
                case "clear": {
                    cart.clear();
                    session.setAttribute("successMsg", "Đã dọn dẹp giỏ hàng!");
                    break;
                }
                default:
                    session.setAttribute("errorMsg", "Thao tác giỏ hàng không được hỗ trợ.");
            }
        } catch (Exception e) {
            session.setAttribute("errorMsg", "Không thể xử lý giỏ hàng: " + e.getMessage());
        }

        session.setAttribute("cartTotal", cart.getTotalMoney());
        session.setAttribute("cartCount", cart.getSize());

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private int parseProductId(HttpServletRequest request) {
        String pIdStr = request.getParameter("productId");
        if (pIdStr == null || pIdStr.trim().isEmpty()) {
            pIdStr = request.getParameter("id");
        }
        if (pIdStr != null && !pIdStr.trim().isEmpty()) {
            try {
                return Integer.parseInt(pIdStr.trim());
            } catch (NumberFormatException ignored) {}
        }
        return 0;
    }
}
