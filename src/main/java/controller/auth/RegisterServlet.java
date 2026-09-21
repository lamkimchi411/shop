package controller.auth;

import controller.BaseServlet;
import dao.DatabaseDao;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;
import java.util.regex.Pattern;

/**
 * Controller: Xử lý Đăng Ký Tài Khoản
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends BaseServlet {

    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[A-Za-z0-9_]{3,50}$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        super.doGet(request, response);
        request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            fullname == null || fullname.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ các thông tin bắt buộc!");
            preserveFormFields(request, username, fullname, email, phone, address);
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!USERNAME_PATTERN.matcher(username.trim()).matches()) {
            request.setAttribute("error", "Tên đăng nhập phải gồm 3–50 ký tự: chữ cái, số hoặc dấu gạch dưới.");
            preserveFormFields(request, username, fullname, email, phone, address);
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
            request.setAttribute("error", "Địa chỉ email không hợp lệ.");
            preserveFormFields(request, username, fullname, email, phone, address);
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự.");
            preserveFormFields(request, username, fullname, email, phone, address);
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Xác nhận mật khẩu không khớp!");
            preserveFormFields(request, username, fullname, email, phone, address);
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        UserDao userDao = DatabaseDao.getInstance().getUserDao();

        if (userDao.findByUsername(username.trim()) != null) {
            request.setAttribute("error", "Tên đăng nhập '" + username + "' đã tồn tại!");
            preserveFormFields(request, username, fullname, email, phone, address);
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (userDao.findByEmail(email.trim()) != null) {
            request.setAttribute("error", "Địa chỉ email đã được sử dụng!");
            preserveFormFields(request, username, fullname, email, phone, address);
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(
                username.trim(),
                password,
                fullname.trim(),
                email.trim(),
                phone != null ? phone.trim() : "",
                address != null ? address.trim() : "",
                "CUSTOMER"
        );

        boolean isRegistered = userDao.insert(newUser);

        if (isRegistered) {
            request.getSession(true).setAttribute("successMsg", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Đăng ký thất bại. Đã có lỗi xảy ra trên hệ thống!");
            preserveFormFields(request, username, fullname, email, phone, address);
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
        }
    }

    private void preserveFormFields(HttpServletRequest request, String username, String fullname, String email, String phone, String address) {
        request.setAttribute("username", username);
        request.setAttribute("fullname", fullname);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);
    }
}
