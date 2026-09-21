package dao;

import dao.impl.CategoryImpl;
import dao.impl.OrderImpl;
import dao.impl.ProductImpl;
import dao.impl.SettingsImpl;
import dao.impl.UserImpl;

/**
 * NGUYÊN LÝ HOẠT ĐỘNG: CONCRETE FACTORY (Nhà máy cụ thể)
 * 
 * Lớp `Database` kế thừa từ `DatabaseDao` và chịu trách nhiệm tạo ra các đối tượng triển khai MySQL JDBC thực tế
 * (ProductImpl, CategoryImpl, OrderImpl, UserImpl, SettingsImpl).
 * 
 * Khi bất kỳ Servlet nào gọi `DatabaseDao.getInstance().getCategoryDao()`, 
 * hàm `@Override public CategoryDao getCategoryDao()` dưới đây sẽ được kích hoạt để trả về một `new CategoryImpl()`.
 */
public class Database extends DatabaseDao {

    /**
     * Khởi tạo và trả về đối tượng ProductImpl thao tác với bảng `products` trong CSDL MySQL.
     */
    @Override
    public ProductDao getProductDao() {
        return new ProductImpl();
    }

    /**
     * Khởi tạo và trả về đối tượng CategoryImpl thao tác với bảng `categories` trong CSDL MySQL.
     */
    @Override
    public CategoryDao getCategoryDao() {
        return new CategoryImpl();
    }

    /**
     * Khởi tạo và trả về đối tượng OrderImpl thao tác với bảng `orders` & `order_details` trong CSDL MySQL.
     */
    @Override
    public OrderDao getOrderDao() {
        return new OrderImpl();
    }

    /**
     * Khởi tạo và trả về đối tượng UserImpl thao tác với bảng `users` trong CSDL MySQL.
     */
    @Override
    public UserDao getUserDao() {
        return new UserImpl();
    }

    /**
     * Khởi tạo và trả về đối tượng SettingsImpl thao tác với bảng `system_settings` trong CSDL MySQL.
     */
    @Override
    public SettingsDao getSettingsDao() {
        return new SettingsImpl();
    }
}
