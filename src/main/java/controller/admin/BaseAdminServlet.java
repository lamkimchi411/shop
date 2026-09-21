package controller.admin;

import dao.Database;
import dao.DatabaseDao;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;

/**
 * NGUYÊN LÝ HOẠT ĐỘNG VÀ VAI TRÒ: BASE ADMIN SERVLET
 * (Tương tự thiết kế trong repository binhdev/java-web-mvc)
 * 
 * 1. `BaseAdminServlet` đóng vai trò là Lớp Cha cho tất cả các Servlet quản trị Admin
 *    (AdminDashboardServlet, AdminCategoryServlet, AdminProductServlet, AdminOrderServlet, AdminUserServlet, AdminSettingsServlet).
 * 
 * 2. Ghi đè phương thức `init(ServletConfig config)`:
 *    - Đảm bảo khởi tạo `DatabaseDao.init(new Database())` cấu hình hệ thống DAO sẵn sàng kết nối CSDL MySQL cho vùng quản trị Admin.
 */
public class BaseAdminServlet extends HttpServlet {

    /**
     * Hàm khởi tạo nâng cao nhận tham số ServletConfig từ Tomcat Container.
     */
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config); // Gọi hàm khởi tạo của Servlet cha (HttpServlet)
        
        // Thiết lập Factory khởi tạo CSDL MySQL JDBC cho Admin
        DatabaseDao.init(new Database());
    }
}
