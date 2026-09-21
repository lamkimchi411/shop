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
        request.setCharacterEncoding("UTF-8");
        if ("upload".equals(request.getParameter("action"))) {
            uploadImage(request, response);
            return;
        }
        saveOrUpdateProduct(request, response);
    }

    private void uploadImage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json;charset=UTF-8");
        Part filePart = request.getPart("imageFile");
        if (filePart == null || filePart.getSize() == 0) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"success\":false,\"message\":\"Chưa chọn tệp ảnh.\"}");
            return;
        }
        String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (!filePart.getContentType().startsWith("image/") || submittedName.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().print("{\"success\":false,\"message\":\"Tệp đã chọn không phải là ảnh hợp lệ.\"}");
            return;
        }
        String safeName = submittedName.replaceAll("[^A-Za-z0-9._-]", "_");
        String savedFileName = System.currentTimeMillis() + "_" + safeName;
        String uploadDir = getServletContext().getRealPath("/") + "static" + File.separator + "images";
        File dir = new File(uploadDir);
        if (!dir.exists() && !dir.mkdirs()) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"success\":false,\"message\":\"Không thể tạo thư mục lưu ảnh.\"}");
            return;
        }
        filePart.write(uploadDir + File.separator + savedFileName);
        String url = request.getContextPath() + "/static/images/" + savedFileName;
        response.getWriter().print("{\"success\":true,\"url\":\"" + url + "\"}");
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
        request.setCharacterEncoding("UTF-8");
        try {
            String idStr = request.getParameter("id");
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String existingImage = request.getParameter("existingImage");
            String imageUrl = request.getParameter("imageUrl");
            if (name == null || name.trim().isEmpty() || price < 0 || quantity < 0) {
                throw new IllegalArgumentException("Thông tin sản phẩm không hợp lệ.");
            }

            String imagePath = imageUrl != null && !imageUrl.trim().isEmpty() ? imageUrl.trim()
                    : (existingImage != null && !existingImage.isEmpty() ? existingImage : "static/images/default-aodai.jpg");
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

            Product product = new Product(name.trim(), price, quantity, imagePath, description != null ? description.trim() : "", categoryId);

            if (idStr != null && !idStr.isEmpty()) {
                product.setId(Integer.parseInt(idStr));
                boolean success = productDao.update(product);
                request.getSession().setAttribute(success ? "successMsg" : "errorMsg", success
                        ? "Cập nhật sản phẩm '" + name + "' thành công!"
                        : "Cập nhật sản phẩm thất bại vì không tìm thấy sản phẩm hoặc cơ sở dữ liệu không phản hồi.");
            } else {
                boolean success = productDao.insert(product);
                request.getSession().setAttribute(success ? "successMsg" : "errorMsg", success
                        ? "Thêm mới sản phẩm '" + name + "' thành công!"
                        : "Thêm sản phẩm thất bại vì cơ sở dữ liệu không phản hồi.");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("errorMsg", "Không thể lưu sản phẩm: " + e.getMessage());
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
