package controller.admin;

import dao.CategoryDao;
import dao.DatabaseDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;

import java.io.IOException;
import java.util.List;

/**
 * Controller: CRUD Quản lý Danh Mục Trang Phục (Admin)
 */
@WebServlet(name = "AdminCategoryServlet", urlPatterns = {"/admin/categories"})
public class AdminCategoryServlet extends BaseAdminServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();

        String action = request.getParameter("action");
        if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success = categoryDao.delete(id);
                if (success) {
                    request.getSession().setAttribute("successMsg", "Xóa danh mục thành công!");
                } else {
                    request.getSession().setAttribute("errorMsg", "Không thể xóa danh mục đang có sản phẩm!");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("errorMsg", "Lỗi dữ liệu danh mục!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }

        List<Category> categories = categoryDao.findAll();
        request.setAttribute("categories", categories);

        if ("edit".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Category category = categoryDao.find(id);
                request.setAttribute("editCategory", category);
            } catch (Exception ignored) {}
        }

        request.getRequestDispatcher("/views/admin/category-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (name == null || name.trim().isEmpty()) {
            request.getSession().setAttribute("errorMsg", "Tên danh mục không được để trống!");
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }

        try {
            Category category = new Category(name.trim(), description != null ? description.trim() : "");
            boolean success;
            if (idStr != null && !idStr.isEmpty()) {
                category.setId(Integer.parseInt(idStr));
                success = categoryDao.update(category);
                request.getSession().setAttribute(success ? "successMsg" : "errorMsg", success
                        ? "Cập nhật danh mục thành công!" : "Cập nhật thất bại vì không tìm thấy danh mục hoặc cơ sở dữ liệu không phản hồi.");
            } else {
                success = categoryDao.insert(category);
                request.getSession().setAttribute(success ? "successMsg" : "errorMsg", success
                        ? "Thêm danh mục mới thành công!" : "Thêm danh mục thất bại vì cơ sở dữ liệu không phản hồi.");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("errorMsg", "Không thể lưu danh mục: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}
