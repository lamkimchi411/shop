package controller.customer;

import controller.BaseServlet;
import dao.CategoryDao;
import dao.DatabaseDao;
import dao.ProductDao;
import dao.SettingsDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Product;
import util.Constants;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * NGUYÊN LÝ HOẠT ĐỘNG: CONTROLLER TRANG CHỦ (HomeServlet)
 * 
 * 1. Anotation `@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})`:
 *    Cấu hình Router định tuyến địa chỉ URL `/home` hoặc đường dẫn gốc `/` vào Servlet này xử lý.
 * 
 * 2. Kế thừa `BaseServlet`:
 *    Nhờ kế thừa `BaseServlet`, khi gọi `super.doGet(request, response)`, dữ liệu Menu `categoryList` 
 *    sẽ tự động được nạp vào Request Scope mà không cần viết lại mã truy vấn danh mục ở đây!
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Gọi hàm doGet của BaseServlet cha để tự động nạp `categoryList` cho Navbar Header
        super.doGet(request, response);

        // 2. Lấy các DAO thông qua Abstract Factory `DatabaseDao.getInstance()`
        ProductDao productDao = DatabaseDao.getInstance().getProductDao();
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        SettingsDao settingsDao = DatabaseDao.getInstance().getSettingsDao();

        // 3. Thực thi truy vấn lấy danh sách sản phẩm mới nhất & sản phẩm nổi bật
        List<Product> newsProductList = productDao.news(Constants.NUMBER_LIMIT);    // Lấy 8 sản phẩm mới
        List<Product> featuredProductList = productDao.featured(Constants.NUMBER_LIMIT); // Lấy 8 sản phẩm nổi bật
        List<Category> categories = categoryDao.findAll(); // Lấy toàn bộ danh mục
        Map<String, String> settings = settingsDao.getSettings(); // Lấy cài đặt website

        // 4. Gắn các danh sách dữ liệu vào Request Attribute để truyền tới file hiển thị (View JSP)
        request.setAttribute("newsProductList", newsProductList);       // Danh sách sản phẩm mới
        request.setAttribute("featuredProductList", featuredProductList); // Danh sách sản phẩm nổi bật
        request.setAttribute("featuredProducts", featuredProductList);    // Tương thích tên biến giao diện cũ
        request.setAttribute("categories", categories);                    // Danh mục sản phẩm
        request.setAttribute("settings", settings);                        // Cài đặt banner/tiêu đề

        // 5. Chuyển hướng xử lý (Forward) đến View trang chủ `/views/customer/index.jsp` để dựng giao diện HTML
        request.getRequestDispatcher("/views/customer/index.jsp").forward(request, response);
    }
}
