package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

/**
 * AuthorizationFilter - Bảo vệ các đường dẫn Quản trị viên (/admin/*) (Jakarta EE / Tomcat 10+)
 */
@WebFilter("/admin/*")
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);

        User account = (session != null) ? (User) session.getAttribute("account") : null;

        if (account == null) {
            // Chưa đăng nhập -> Chuyển sang trang Login kèm thông báo
            httpRequest.getSession(true).setAttribute("errorMsg", "Vui lòng đăng nhập tài khoản Quản trị để tiếp tục.");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        if (!account.isAdmin()) {
            // Đã đăng nhập nhưng không có quyền ADMIN -> Chuyển sang trang chủ
            httpRequest.getSession().setAttribute("errorMsg", "Bạn không có quyền truy cập trang quản trị!");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
            return;
        }

        // Đạt điều kiện -> Tiếp tục chuỗi Filter
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
