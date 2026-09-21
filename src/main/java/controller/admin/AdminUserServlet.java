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
        List<User> userList = userDao.findAll();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/views/admin/user-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDao userDao = DatabaseDao.getInstance().getUserDao();
        String action = request.getParameter("action");
        if ("updateRole".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String newRole = request.getParameter("role");

                User user = userDao.find(id);
                if (user != null) {
                    user.setRole(newRole);
                    boolean updated = userDao.update(user);
                    if (updated) {
                        request.getSession().setAttribute("successMsg", "Cập nhật vai trò người dùng thành công!");
                    } else {
                        request.getSession().setAttribute("errorMsg", "Cập nhật thất bại!");
                    }
                }
            } catch (Exception e) {
                request.getSession().setAttribute("errorMsg", "Lỗi dữ liệu: " + e.getMessage());
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
