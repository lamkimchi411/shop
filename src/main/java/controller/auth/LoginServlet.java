package controller.auth;

import controller.BaseServlet;
import dao.DatabaseDao;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

/**
 * Controller: Xử lý Đăng Nhập
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        super.doGet(request, response);

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ Tên đăng nhập và Mật khẩu!");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        UserDao userDao = DatabaseDao.getInstance().getUserDao();
        User user = userDao.checkLogin(username.trim(), password);

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("account", user);
            session.setAttribute("successMsg", "Đăng nhập thành công. Chào mừng bạn trở lại!");
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        }
    }
}
