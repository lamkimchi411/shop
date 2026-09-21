package controller;

import dao.CategoryDao;
import dao.Database;
import dao.DatabaseDao;
import model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * NGUYÊN LÝ HOẠT ĐỘNG: TEMPLATE METHOD & BASE SERVLET PATTERN
 * (Tương tự thiết kế trong repository binhdev/java-web-mvc)
 * 
 * VAI TRÒ VÀ CÔNG DỤNG:
 * 1. `BaseServlet` kế thừa `jakarta.servlet.http.HttpServlet`, đóng vai trò làm Lớp Cha (Parent Class) 
 *    cho tất cả các Servlet phía khách hàng (Frontend) như HomeServlet, ProductListServlet, CartServlet...
 * 
 * 2. Trong hàm `init()`:
 *    - Thực thi tự động một lần duy nhất khi ứng dụng Web khởi chạy.
 *    - Đăng ký `DatabaseDao.init(new Database())` thiết lập Factory MySQL JDBC sẵn sàng phục vụ toàn bộ ứng dụng.
 * 
 * 3. Trong hàm `doGet()`:
 *    - Lấy danh sách danh mục sản phẩm (`categoryList`) từ `DatabaseDao.getInstance().getCategoryDao().findAll()`.
 *    - Đính kèm `categoryList` vào `request.setAttribute("categoryList", categoryList)`.
 *    - Nhờ đó, bất kỳ Servlet con nào gọi `super.doGet(req, resp)` thì các trang JSP hiển thị đều TỰ ĐỘNG có danh sách Menu danh mục mà KHÔNG cần viết lại mã tải danh mục ở từng Servlet!
 */
public class BaseServlet extends HttpServlet {

    /**
     * Hàm khởi tạo của Servlet (Life-cycle method).
     * Khởi chạy khi Servlet Container (Tomcat) nạp Servlet này vào bộ nhớ.
     */
    @Override
    public void init() throws ServletException {
        // Đăng ký Concrete Factory (Database) cho Abstract Factory (DatabaseDao)
        DatabaseDao.init(new Database());
    }

    /**
     * Phương thức xử lý yêu cầu GET từ trình duyệt.
     * Nạp danh sách danh mục đưa vào Request Scope để các Header/Navbar JSP hiển thị Menu động.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Gọi DAO truy vấn danh sách toàn bộ danh mục sản phẩm
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        List<Category> categoryList = categoryDao.findAll();

        // 2. Đưa danh sách vào Attribute của Request để giao diện JSP truy cập bằng EL (${categoryList})
        req.setAttribute("categoryList", categoryList);
    }
}
