package controller.admin;

import dao.DatabaseDao;
import dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;
import java.util.List;

/**
 * Controller: Admin Quản Lý Người Dùng
 */
@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admin/users"})
public class AdminUserServlet extends BaseAdminServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDao userDao = DatabaseDao.getInstance().getUserDao();
        String action = request.getParameter("action");

        if ("edit".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                User user = userDao.find(id);
                if (user == null) {
                    request.getSession().setAttribute("errorMsg", "Không tìm thấy người dùng cần chỉnh sửa.");
                    response.sendRedirect(request.getContextPath() + "/admin/users");
                    return;
                }
                request.setAttribute("editUser", user);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMsg", "Mã người dùng không hợp lệ.");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }
        }

        List<User> userList = userDao.findAll();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/views/admin/user-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDao userDao = DatabaseDao.getInstance().getUserDao();
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("update".equals(action) || "updateRole".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                User user = userDao.find(id);
                if (user != null) {
                    String role = request.getParameter("role");
                    if (!"ADMIN".equals(role) && !"CUSTOMER".equals(role)) {
                        throw new IllegalArgumentException("Vai trò không hợp lệ.");
                    }

                    if ("update".equals(action)) {
                        String username = request.getParameter("username");
                        String fullname = request.getParameter("fullname");
                        String email = request.getParameter("email");
                        if (username == null || !username.trim().matches("[A-Za-z0-9._-]{3,50}")) {
                            throw new IllegalArgumentException("Tên đăng nhập gồm 3-50 ký tự: chữ, số, dấu chấm, gạch dưới hoặc gạch ngang.");
                        }
                        if (fullname == null || fullname.trim().isEmpty() || email == null || email.trim().isEmpty()) {
                            throw new IllegalArgumentException("Tên đăng nhập, họ tên và email không được để trống.");
                        }
                        User sameUsername = userDao.findByUsername(username.trim());
                        if (sameUsername != null && sameUsername.getId() != id) {
                            throw new IllegalArgumentException("Tên đăng nhập này đã được sử dụng.");
                        }
                        user.setUsername(username.trim());
                        user.setFullname(fullname.trim());
                        user.setEmail(email.trim());
                        user.setPhone(request.getParameter("phone") != null ? request.getParameter("phone").trim() : "");
                        user.setAddress(request.getParameter("address") != null ? request.getParameter("address").trim() : "");
                    }
                    user.setRole(role);
                    String newPassword = request.getParameter("newPassword");
                    String confirmPassword = request.getParameter("confirmPassword");
                    if (newPassword != null && !newPassword.isEmpty()) {
                        if (newPassword.length() < 6) {
                            throw new IllegalArgumentException("Mật khẩu mới phải có ít nhất 6 ký tự.");
                        }
                        if (!newPassword.equals(confirmPassword)) {
                            throw new IllegalArgumentException("Xác nhận mật khẩu mới không khớp.");
                        }
                    }
                    boolean updated = userDao.update(user);
                    if (newPassword != null && !newPassword.isEmpty()) {
                        if (!userDao.updatePassword(id, newPassword)) {
                            throw new IllegalStateException("Không thể cập nhật mật khẩu do cơ sở dữ liệu không phản hồi.");
                        }
                    }
                    if (updated) {
                        request.getSession().setAttribute("successMsg", "Cập nhật thông tin người dùng thành công!");
                    } else {
                        request.getSession().setAttribute("errorMsg", "Cập nhật thất bại!");
                    }
                } else {
                    request.getSession().setAttribute("errorMsg", "Không tìm thấy người dùng cần cập nhật.");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("errorMsg", "Lỗi dữ liệu: " + e.getMessage());
            }
        } else if ("toggleActive".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean active = Boolean.parseBoolean(request.getParameter("active"));
                User currentUser = (User) request.getSession().getAttribute("account");
                if (currentUser != null && currentUser.getId() == id && !active) {
                    throw new IllegalArgumentException("Không thể khóa chính tài khoản đang đăng nhập.");
                }
                if (userDao.setActive(id, active)) {
                    request.getSession().setAttribute("successMsg", active ? "Đã mở khóa tài khoản." : "Đã khóa tài khoản.");
                } else {
                    request.getSession().setAttribute("errorMsg", "Không thể thay đổi trạng thái tài khoản.");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("errorMsg", "Lỗi dữ liệu: " + e.getMessage());
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
