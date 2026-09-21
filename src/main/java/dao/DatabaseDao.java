package dao;

/**
 * NGUYÊN LÝ HOẠT ĐỘNG: ABSTRACT FACTORY DESIGN PATTERN
 * 
 * Lớp `DatabaseDao` đóng vai trò là một "Nhà Máy Tối Cao" (Abstract Factory) quy định danh sách các DAO
 * mà ứng dụng cần cung cấp (ProductDao, CategoryDao, OrderDao, UserDao, SettingsDao).
 * 
 * Ưu điểm của kiến trúc này (giống binhdev/java-web-mvc):
 * 1. Tách biệt hoàn toàn phần Servlet (Controller) với phần triển khai thực tế dưới Database (Impl).
 * 2. Servlet không bao giờ gọi trực tiếp `new CategoryImpl()` hay `new ProductImpl()`.
 * 3. Servlet chỉ giao tiếp qua `DatabaseDao.getInstance().getCategoryDao()`.
 *    -> Giúp ứng dụng cực kỳ dễ mở rộng (ví dụ sau này muốn đổi từ MySQL sang PostgreSQL/MongoDB chỉ cần tạo lớp Factory mới mà không sửa 1 dòng code Servlet nào!).
 */
public abstract class DatabaseDao {

    // Biến lưu giữ thể hiện duy nhất của Factory đang hoạt động trong hệ thống
    private static DatabaseDao instance;

    /**
     * Phương thức khởi tạo/đăng ký một Factory triển khai cụ thể cho hệ thống.
     * Được gọi đầu tiên trong hàm `init()` của `BaseServlet` hoặc `BaseAdminServlet`.
     *
     * @param inst Đối tượng triển khai Factory (ví dụ: new Database())
     */
    public static void init(DatabaseDao inst) {
        instance = inst;
    }

    /**
     * Phương thức lấy thể hiện Factory hiện tại.
     * Nguyên lý tự động phòng ngừa (Fallback): Nếu chưa được gọi `init()`, nó sẽ tự động khởi tạo `new Database()`.
     *
     * @return Thể hiện DatabaseDao hiện tại
     */
    public static DatabaseDao getInstance() {
        if (instance == null) {
            instance = new Database(); // Tự động khởi tạo triển khai MySQL Database mặc định
        }
        return instance;
    }

    // Các phương thức Abstract ép buộc các Factory con phải định nghĩa cách khởi tạo DAO cụ thể:

    /** Trả về đối tượng DAO thao tác với Sản Phẩm */
    public abstract ProductDao getProductDao();

    /** Trả về đối tượng DAO thao tác với Danh Mục */
    public abstract CategoryDao getCategoryDao();

    /** Trả về đối tượng DAO thao tác với Đơn Hàng */
    public abstract OrderDao getOrderDao();

    /** Trả về đối tượng DAO thao tác với Người Dùng */
    public abstract UserDao getUserDao();

    /** Trả về đối tượng DAO thao tác với Cài Đặt Hệ Thống */
    public abstract SettingsDao getSettingsDao();
}
