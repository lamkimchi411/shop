package controller.customer;

import controller.BaseServlet;
import dao.CategoryDao;
import dao.DatabaseDao;
import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Product;

import java.io.IOException;
import java.util.List;

/**
 * Controller: Trang Danh Sách & Tìm Kiếm / Lọc Sản Phẩm
 */
@WebServlet(name = "ProductListServlet", urlPatterns = {"/products"})
public class ProductListServlet extends BaseServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        super.doGet(request, response);

        ProductDao productDao = DatabaseDao.getInstance().getProductDao();
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();

        String catIdParam = request.getParameter("catId");
        String keyword = request.getParameter("keyword");

        List<Product> products;
        Category selectedCategory = null;
        Integer selectedCatId = null;

        if (keyword != null && !keyword.trim().isEmpty()) {
            products = productDao.searchByName(keyword.trim());
            request.setAttribute("searchKeyword", keyword.trim());
        } else if (catIdParam != null && !catIdParam.isEmpty()) {
            try {
                int catId = Integer.parseInt(catIdParam);
                products = productDao.findByCategory(catId);
                selectedCategory = categoryDao.find(catId);
                selectedCatId = catId;
            } catch (NumberFormatException e) {
                products = productDao.findAll();
            }
        } else {
            products = productDao.findAll();
        }

        List<Category> categories = categoryDao.findAll();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", selectedCategory);
        request.setAttribute("selectedCatId", selectedCatId);

        request.getRequestDispatcher("/views/customer/products.jsp").forward(request, response);
    }
}
