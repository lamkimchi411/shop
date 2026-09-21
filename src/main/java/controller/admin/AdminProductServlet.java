package controller.admin;

import dao.CategoryDao;
import dao.DatabaseDao;
import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Category;
import model.Product;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

/**
 * Controller: CRUD Quản lý Sản Phẩm (Admin)
 */
@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/products"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AdminProductServlet extends BaseAdminServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        saveOrUpdateProduct(request, response);
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDao productDao = DatabaseDao.getInstance().getProductDao();
        List<Product> products = productDao.findAll();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/views/admin/product-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        List<Category> categories = categoryDao.findAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductDao productDao = DatabaseDao.getInstance().getProductDao();
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();

        Product existingProduct = productDao.find(id);
        List<Category> categories = categoryDao.findAll();

        request.setAttribute("product", existingProduct);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
    }

    private void saveOrUpdateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDao productDao = DatabaseDao.getInstance().getProductDao();

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String description = request.getParameter("description");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String existingImage = request.getParameter("existingImage");

        String imagePath = existingImage != null && !existingImage.isEmpty() ? existingImage : "static/images/default-aodai.jpg";
        Part filePart = request.getPart("imageFile");

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/") + "static" + File.separator + "images";
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String savedFileName = System.currentTimeMillis() + "_" + fileName;
            filePart.write(uploadDir + File.separator + savedFileName);
            imagePath = "static/images/" + savedFileName;
        }

        Product product = new Product(name, price, quantity, imagePath, description, categoryId);

        if (idStr != null && !idStr.isEmpty()) {
            product.setId(Integer.parseInt(idStr));
            productDao.update(product);
            request.getSession().setAttribute("successMsg", "Cập nhật sản phẩm '" + name + "' thành công!");
        } else {
            productDao.insert(product);
            request.getSession().setAttribute("successMsg", "Thêm mới sản phẩm '" + name + "' thành công!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductDao productDao = DatabaseDao.getInstance().getProductDao();
        boolean success = productDao.delete(id);
        if (success) {
            request.getSession().setAttribute("successMsg", "Đã xóa sản phẩm thành công!");
        } else {
            request.getSession().setAttribute("errorMsg", "Không thể xóa sản phẩm do đang có liên kết đơn hàng!");
        }
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
